// java function that only runs on specific files
'use strict';

var usernamePage = document.querySelector('#username-page');
var chatPage = document.querySelector('#chat-page');
var usernameForm = document.querySelector('#usernameForm');
var messageForm = document.querySelector('#messageForm');
var messageInput = document.querySelector('#message');
var messageArea = document.querySelector('#messageArea');
var connectingElement = document.querySelector('.connecting');

var stompClient = null;
var username = null;
var nickname = null;
var connected = false;

// ? this won't work becasue each connection is independent
var numOfConnections = 0;

// * room selection
// var roomSelection = document.querySelector('input[name="room"]:checked');

var colors = [
    '#2196F3', '#32c787', '#00BCD4', '#ff5652',
    '#ffc107', '#ff85af', '#FF9800', '#39bbb0'
];

// call the connect functions
$(document).ready(function () {
    if (!stompClient) {connect();}
});

// ! event listeners
// connectForm.addEventListener('submit', connect, true)
messageForm.addEventListener('submit', sendMessage, true)

// ! connection and subscription to the socket ================================

function connect() {
    nickname = document.querySelector('#nickname').innerHTML;
    username = "@" + document.querySelector('#username').innerHTML;
    console.log("username:" + username );
    console.log("nickname:" + nickname );

    if(username) {
        // connect to the socket
        var socket = new SockJS('/ws');
        stompClient = Stomp.over(socket);
        stompClient.connect({}, onConnected, onError);
    }
}

function onConnected() {
    // ! change here for the subscription channels
    // Subscribe to the Public Topic
    // stompClient.subscribe('/topic/public', onMessageReceived);
    
    // * subsribe to differnt channels
    // var roomSelection = document.querySelector('input[name="chatroomName"]:checked').value;
    var roomSelection = document.querySelector('#chatroomName').innerHTML;
    if (roomSelection) {
        stompClient.subscribe(`/topic/${roomSelection}`, onMessageReceived);
    }

    // Tell your username to the server
    stompClient.send(`/app/chat.addUser${roomSelection}`,
    	// ?????? What is first argument
        {},
        JSON.stringify({sender: username, type: 'JOIN'})
    )
    connectingElement.classList.add('hidden');
}


// ! error handlers =============================================================
function onError(error) {
    connectingElement.textContent = 'Could not connect to WebSocket server. Please refresh this page to try again!';
    connectingElement.style.color = 'red';
}



// ! send message ===============================================================
function sendMessage(event) {
    var messageContent = messageInput.value.trim();

    console.log("sending message")

    if(messageContent && stompClient) {
        // ! change this for send message channel
        // public chat
        // var chatMessage = {
        //     sender: username,
        //     content: messageInput.value,
        //     type: 'CHAT'
        // };
        // stompClient.send("/app/chat.sendMessage", {}, JSON.stringify(chatMessage));

        // room send message
        var roomSelection = document.querySelector('#chatroomName').innerHTML;
        var chatMessageRoom = {
            sender: username,
            content: messageInput.value,
            type: 'CHAT'
        };

        stompClient.send(`/app/chat.sendMessage${roomSelection}`, {}, JSON.stringify(chatMessageRoom));
        messageInput.value = ''; // empty the inputn value
    }
    event.preventDefault();
}

// ! handles incoming messages ===============================================
function onMessageReceived(payload) {
    // message is only one at a time
    console.log(stompClient.counter);
    var message = JSON.parse(payload.body);

    if (message.type == "UPDATEONLINE") {
        if (message.onlineNumber > 0) {
            console.log("running");
            const span = document.querySelector('#number-connected');
            span.innerHTML = message.onlineNumber;
        }
        return;
    }

    // create list element
    var messageElement = document.createElement('li');
    messageElement.style['padding-left'] = '10px';

    if(message.type === 'JOIN') {
        // if a user joins
        messageElement.classList.add('event-message');
        message.content = message.sender + ' joined';

        // change the number of number of connections.
        // TODO we want to something here and update the online numbers, but this is currently stateless
        // const span = document.querySelector('#number-connected');
        // span.innerHTML = ++span.innerHTML;


    } else if (message.type === 'LEAVE') {
        // if a user leaves
        messageElement.classList.add('event-message');
        message.content = message.sender + ' left';

        // TODO we want to something here and update the online numbers
        // const span = document.querySelector('#number-connected');
        // span.innerHTML = --span.innerHTML;

    } else {
        // else display a message
        messageElement.classList.add('chat-message');
        messageElement.style['word-wrap']='break-word';
        //messageElement.style['list-style-type'] = message.sender[1];
 
        if (username == message.sender) {
	
            // if it is the user
            messageElement.style['background-color'] = '#2f3134';
            messageElement.style['color'] = 'white';
            messageElement.style['text-align'] = 'right';
            messageElement.style['padding-right'] = '15px';
            messageElement.style['animation'] = 'fadeSent .5s';
            //messageElement.style['direction'] = 'rtl';
            
            
            // username and text element
            var usernameElement = document.createElement('span');
            var usernameText = document.createTextNode('Me');

        }
        else {
            messageElement.style['background-color'] = '#435f7a';
            messageElement.style['padding-left'] = '15px';
            messageElement.style['color'] = 'white';
            messageElement.style['animation'] = 'fadeReceived .5s';
             // avator pic and first initial
            //var avatarElement = document.createElement('i');

            //var avatarText = document.createTextNode(message.sender[1]);
            //avatarElement.appendChild(avatarText);
            //avatarElement.style['background-color'] = getAvatarColor(message.sender);

            //messageElement.appendChild(avatarElement);

            var usernameElement = document.createElement('span');
            var usernameText = document.createTextNode(message.sender);
        }
        usernameElement.appendChild(usernameText);
        messageElement.appendChild(usernameElement);
    }

    // create and element and also seeting the textNode
    var textElement = document.createElement('p');
    textElement.style['margin-bottom']='0';
    var messageText = document.createTextNode(message.content);
    
    
    var textElement2 = document.createElement('p');
    var date = document.createTextNode(formatAMPM());
   
    textElement2.style['color']='gray';
    textElement2.style['font-size']='.8em';
    
    textElement.appendChild(messageText);
    textElement2.appendChild(date);

    messageElement.appendChild(textElement);
    messageElement.appendChild(textElement2);

    messageArea.appendChild(messageElement);
    messageArea.scrollTop = messageArea.scrollHeight;

    if (message.onlineNumber > 0) {
        console.log("running");
        const span = document.querySelector('#number-connected');
        span.innerHTML = message.onlineNumber;
    }
}

// ! avatar color =================================================================
function getAvatarColor(messageSender) {
    var hash = 0;
    for (var i = 0; i < messageSender.length; i++) {
        hash = 31 * hash + messageSender.charCodeAt(i);
    }

    var index = Math.abs(hash % colors.length);
    return colors[index];
}

function getDate(){
	const pad = (n, s=2) => (`${new Array(s).fill(0)}${n}`).slice(-s);
	const d = new Date();
	
	return `${pad(d.getMonth()+1)}/${pad(d.getDate())}`;
}

function formatAMPM() {
	const date = new Date();
  	var hours = date.getHours();
  	var minutes = date.getMinutes();
  	var seconds = date.getSeconds();
  	var ampm = hours >= 12 ? 'PM' : 'AM';
  	hours = hours % 12;
  	hours = hours ? hours : 12; // the hour '0' should be '12'
  	minutes = minutes < 10 ? '0'+minutes : minutes;
  	var strTime = hours + ':' + minutes + ' ' + ampm;
  	return strTime;
}

