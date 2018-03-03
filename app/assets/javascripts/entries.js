document.addEventListener("DOMContentLoaded", function(event) {

  // only run the code, when duration-timer element is present
  if (document.getElementById("duration-timer") != null) {
    var startButton = document.getElementById("start-button");
    var stopButton = document.getElementById("stop-button");
    var timerSubmissionButton = document.getElementById("duration-timer-submission");

    var timerElementHours = document.getElementById("duration-hours");
    var timerElementMinutes = document.getElementById("duration-minutes");
    var timerElementSeconds = document.getElementById("duration-seconds");

    timerElementHours.value = "00";
    timerElementMinutes.value = "00";
    timerElementSeconds.value = "00";



    var timer;
    var initialDate;

    var withLeadingZero = function(num) {
      if (num < 10) {
        return "0" + num.toString();
      } else {
        return num.toString();
      }
    };

    startButton.addEventListener("click", function(event) {
      // starts timer
      console.log("start clicked");
      initialDate = new Date();

      timer = setInterval(function() {
        // initialDate++;
        var timePassedInSeconds = (new Date() - initialDate) / 1000;

        var timePassedSeconds = Math.floor(timePassedInSeconds % 60);
        var timePassedMinutes = Math.floor((timePassedInSeconds / 60) % 60);
        var timePassedHours = Math.floor(timePassedInSeconds / 3600);

        timerElementHours.value = withLeadingZero(timePassedHours);
        timerElementMinutes.value = withLeadingZero(timePassedMinutes);
        timerElementSeconds.value = withLeadingZero(timePassedSeconds);

      }, 1000);

      // disables form fields
      timerSubmissionButton.disabled = true;

      // disables this button, enable stop button
      startButton.disabled = true;
      stopButton.disabled = false;
    });

    stopButton.addEventListener("click", function(event) {
      // stops timer
      console.log("stop clicked");
      clearInterval(timer);

      // enables form fields
      // disables this button, enable start button
      startButton.disabled = false;
      stopButton.disabled = true;
      timerSubmissionButton.disabled = false;
    });

    // disable stop button, when page is loaded
    stopButton.disabled = true;
  }
});
