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

// ? this won't work becasue each connection is independent
var numOfConnections = 0;

// * room selection\
// var roomSelection = document.querySelector('input[name="room"]:checked');

var colors = [
    '#2196F3', '#32c787', '#00BCD4', '#ff5652',
    '#ffc107', '#ff85af', '#FF9800', '#39bbb0'
];



// ! connection and subscription to the socket =================================
// this allows us to connect to the server
function connect(event) {
    username = document.querySelector('#name').value.trim();

    if(username) {
        // change the approqaite html elements
        usernamePage.classList.add('hidden');
        chatPage.classList.remove('hidden');
        var roomName = document.querySelector('#room-name');
        roomName.innerHTML = document.querySelector('input[name="room"]:checked').value;
        document.querySelector('#username').innerHTML = "Welcome " + username + "!";



        // numOfConnections++; // add number of connection
        // change the number of number of connections.
        // const span = document.querySelector('#number-connected');
        // span.innerHTML = numOfConnections;
        // console.log('Number of connections changed to ' + numOfConnections);

        var socket = new SockJS('/ws');
        stompClient = Stomp.over(socket);
        stompClient.connect({}, onConnected, onError);
    }
    event.preventDefault();
}


function onConnected() {
    // ! change here for the subscription channels
    // Subscribe to the Public Topic
    stompClient.subscribe('/topic/public', onMessageReceived);
    // * subsribe to differnt channels
    
    // if (username == "kenny") {
    //     stompClient.subscribe('/topic/private', onMessageReceived);
    // }
    // stompClient.subscribe('/topic/private', onMessageReceived);
    // stompClient.subscribe('/topic/room1', onMessageReceived);
    var roomSelection = document.querySelector('input[name="room"]:checked').value;
    // console.log(roomSelection);
    if (roomSelection) {
        stompClient.subscribe(`/topic/${roomSelection}`, onMessageReceived);
    }
    // stompClient.subscribe('/topic/room1', onMessageReceived);


    // Tell your username to the server
    stompClient.send("/app/chat.addUser",
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

    if(messageContent && stompClient) {
        // ! change this for send message channel
        // public chat
        // var chatMessage = {
        //     sender: username,
        //     content: messageInput.value,
        //     type: 'CHAT'
        // };
        // stompClient.send("/app/chat.sendMessage", {}, JSON.stringify(chatMessage));

        // send mesasge to specifi channels
        // var chatMessagePrivate = {
        //     sender: username,
        //     content: messageInput.value + " private",
        //     type: 'CHAT'
        // };

        // stompClient.send("/app/chat.sendMessagePrivate", {}, JSON.stringify(chatMessagePrivate));
        // stompClient.send("/app/chat.sendMessageroom1", {}, JSON.stringify(chatMessagePrivate));
        // stompClient.send(`/app/chat.sendMessage${roomSelection}`, {}, JSON.stringify(chatMessagePrivate));

        
        // room send message
        var roomSelection = document.querySelector('input[name="room"]:checked').value;
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
    var message = JSON.parse(payload.body);

    // create list element
    var messageElement = document.createElement('li');

    if(message.type === 'JOIN') {
        // if a user joins
        messageElement.classList.add('event-message');
        message.content = message.sender + ' joined!';


        // change the number of number of connections.
        // TODO we want to something here and update the online numbers, but this is currently stateless
        const span = document.querySelector('#number-connected');
        span.innerHTML = ++span.innerHTML;


    } else if (message.type === 'LEAVE') {
        // if a user leaves
        messageElement.classList.add('event-message');
        message.content = message.sender + ' left!';

        // TODO we want to something here and update the online numbers
        const span = document.querySelector('#number-connected');
        span.innerHTML = --span.innerHTML;


    } else {
        // else display a message

        // console.log(username)
        // console.log(message.sender)


        messageElement.classList.add('chat-message');

        if (username == message.sender) {
            // if it is the user
            
            messageElement.style['background-color'] = '#ee706e';
            messageElement.style['text-align'] = 'right';
            // messageElement.style['display'] = 'flex';
            // messageElement.style['margin-left'] = 'auto';
            // messageElement.style['margin-right'] = '0';

            // username and text element
            var usernameElement = document.createElement('span');
            var usernameText = document.createTextNode('Me');

        }
        else {
            messageElement.style['background-color'] = 'rgb(116, 220, 129)';
             // avator pic and first initial
            var avatarElement = document.createElement('i');

            var avatarText = document.createTextNode(message.sender[0]);
            avatarElement.appendChild(avatarText);
            avatarElement.style['background-color'] = getAvatarColor(message.sender);

            messageElement.appendChild(avatarElement);


            var usernameElement = document.createElement('span');
            var usernameText = document.createTextNode(message.sender);
        }

        
        usernameElement.appendChild(usernameText);

        messageElement.appendChild(usernameElement);
    }

    // create and element and also seeting the textNode
    var textElement = document.createElement('p');
    var messageText = document.createTextNode(message.content);
    textElement.appendChild(messageText);

    messageElement.appendChild(textElement);

    messageArea.appendChild(messageElement);
    messageArea.scrollTop = messageArea.scrollHeight;
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


// ! eventhandler for submit buttons ===============================================
usernameForm.addEventListener('submit', connect, true)
messageForm.addEventListener('submit', sendMessage, true)
