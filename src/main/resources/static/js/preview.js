var e = document.querySelector('.channel');
e.onmouseover = function() {
  document.querySelector('.channel').innerText = document.querySelector('.channelNickname').innerText;
}
e.onmouseout = function() {
  document.querySelector('.channel').innerText = '';
}