$(function(){
  'use strict';

  // 更新するタイマー
  var timer = document.getElementById('timer');

  // 時間選択
  var min;

  // それぞれのボタンを取得
  var set = document.getElementById('set');
  var reset = document.getElementById('reset');
  var start = document.getElementById('start');

  var startTime;
  var timeLeft;
  var timeToCountDown = 0;
  var timerId;

  // タイマーが動作しているかどうか
  var isRunning = false;

  function updateTimer(t){
    var d = new Date(t);
    var m = d.getMinutes();
    var s = d.getSeconds();
    var timerstring;

    // timerstringに残り時間を代入し、タイマーを書き換える
    m = ('0' + m).slice(-2);
    s = ('0' + s).slice(-2);
    timerstring =  m + ':' + s;
    timer.textContent = timerstring;
    document.title = timerstring;
  }

  // モーダルを閉じる
  $('.close-modal').click(function(){
    $('#timer-modal').fadeOut();
  });


  // カウントダウン機能
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

        // プッシュ通知
        Push.create("ORT.", {
            body: "終了です。お疲れ様でした！",
            timeout: 8000,
            onClick: function () {
                window.focus();
                this.close();
            }
        });

        return;
      }
      updateTimer(timeLeft);
      countDown();
    }, 10);
  }


  // startボタンの挙動
  start.addEventListener('click', function(){

    // タイマーの時間が0の場合にstartを押したらメッセージを表示する
    if (timeToCountDown === 0){
      var fadeOutMsg = function(){

        // FIXME クラス名変えたい
        $('.message-set').fadeOut();
      };

      $('.message-set').fadeIn();
      setTimeout(fadeOutMsg,3000);
      return
    };

    // startを押した際にタイマーが動作している場合・していない場合で条件分岐
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

  // setボタンの挙動
  set.addEventListener('click', function(){
    if (isRunning === true){
      return;
    }
    min = parseInt(document.getElementById('min').value);
    timeToCountDown = min * 60 * 1000;
    if (timeToCountDown >= 60 * 60 * 1000){
      timeToCountDown = 0;
    }

    // 投稿画面の時間選択にも反映させる
    $("#select_time").val(min);

    // プッシュ通知の許可
    // iOSではブラウザ通知に対応していないためエラーになるが、エラーになっても処理は続けて欲しい
    try {
      Push.Permission.request();
    }
    finally {
      updateTimer(timeToCountDown);
    }

  });

  // resetボタンの挙動
  reset.addEventListener('click', function(){
    timeToCountDown = 0;
    updateTimer(timeToCountDown);
  });


})();
