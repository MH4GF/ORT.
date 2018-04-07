$(function(){
  'use strict';

  var timer = document.getElementById('timer');
  var min;
  var set = document.getElementById('set');
  var reset = document.getElementById('reset');
  var start = document.getElementById('start');

  var startTime;
  var timeLeft;
  var timeToCountDown = 0;
  var timerId;
  var isRunning = false;

  function updateTimer(t){
    var d = new Date(t);
    var m = d.getMinutes();
    var s = d.getSeconds();
    var timerstring;
    m = ('0' + m).slice(-2);
    s = ('0' + s).slice(-2);
    timerstring =  m + ':' + s;
    timer.textContent = timerstring;
    document.title = timerstring;
  }

  $('.close-modal').click(function(){
    $('#timer-modal').fadeOut();
  });

  function countDown(){
    timerId = setTimeout(function(){
      timeLeft = timeToCountDown - (Date.now() - startTime);
      if (timeLeft < 0){
        isRunning = false;
        clearTimeout(timerId);
        timeLeft = 0;
        timeToCountDown = 0;
        updateTimer(timeLeft);
        $('#timer-modal').fadeOut();
        return;
      }
      updateTimer(timeLeft);
      countDown();
    }, 10);
  }

  start.addEventListener('click', function(){
    if (isRunning === false){
      isRunning = true;
      start.textContent = 'Stop';
      startTime = Date.now();
      countDown()
    } else {
      isRunning = false;
      start.textContent = 'Start';
      timeToCountDown = timeLeft;
      clearTimeout(timerId);
    }
  });

  set.addEventListener('click', function(){
    if (isRunning === true){
      return;
    }
    min = parseInt(document.getElementById('min').value);
    timeToCountDown = min * 60 * 1000;
    if (timeToCountDown >= 60 * 60 * 1000){
      timeToCountDown = 0;
    }
    updateTimer(timeToCountDown);
  });

  reset.addEventListener('click', function(){
    timeToCountDown = 0;
    updateTimer(timeToCountDown);
  });
})();
