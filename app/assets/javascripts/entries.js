document.addEventListener("DOMContentLoaded", function(event) {

  // only run the code, when duration-timer element is present
  if (document.getElementById("duration-timer") != null) {
    var startButton = document.getElementById("start-button");
    var stopButton = document.getElementById("stop-button");
    var timerSubmissionButton = document.getElementById("duration-timer-submission");

    var timerElementHours = document.getElementById("duration-hours");
    var timerElementMinutes = document.getElementById("duration-minutes");
    var timerElementSeconds = document.getElementById("duration-seconds");

    var timer;
    var initialDate;

    var withLeadingZero = function(num) {
      if (num < 10) {
        return "0" + num.toString();
      } else {
        return num.toString();
      }
    };

    // make sure each field is formatted properly ("00")
    timerElementHours.value = withLeadingZero(parseInt(timerElementHours.value));
    timerElementMinutes.value = withLeadingZero(parseInt(timerElementMinutes.value));
    timerElementSeconds.value = withLeadingZero(parseInt(timerElementSeconds.value));

    startButton.addEventListener("click", function(event) {
      // start timer
      initialDate = new Date();

      // get the current timer value from form and convert it to seconds
      var previousTimeInSeconds = (parseInt(timerElementHours.value) * 3600) +
                                  (parseInt(timerElementMinutes.value) * 60) +
                                  parseInt(timerElementSeconds.value);

      timer = setInterval(function() {
        var timePassedInSeconds = ((new Date() - initialDate) / 1000) + previousTimeInSeconds;

        var timePassedSeconds = Math.floor(timePassedInSeconds % 60);
        var timePassedMinutes = Math.floor((timePassedInSeconds / 60) % 60);
        var timePassedHours = Math.floor(timePassedInSeconds / 3600);

        timerElementHours.value = withLeadingZero(timePassedHours);
        timerElementMinutes.value = withLeadingZero(timePassedMinutes);
        timerElementSeconds.value = withLeadingZero(timePassedSeconds);
      }, 1000);

      // disable add button, disable start button, enable stop button
      timerSubmissionButton.disabled = true;
      startButton.disabled = true;
      stopButton.disabled = false;
    });

    stopButton.addEventListener("click", function(event) {
      // stop timer
      clearInterval(timer);

      // enable add button, disable stop button, enable start button
      timerSubmissionButton.disabled = false;
      stopButton.disabled = true;
      startButton.disabled = false;
    });

    // disable stop button, when page is loaded
    stopButton.disabled = true;
  }
});
