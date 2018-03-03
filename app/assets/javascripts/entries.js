document.addEventListener("DOMContentLoaded", function(event) {

  // only run the code, when duration-timer element is present
  if (document.getElementById("duration-timer") != null) {
    var startButton = document.getElementById("start-button");
    var stopButton = document.getElementById("stop-button");
    var timerSubmissionButton = document.getElementById("duration-timer-submission");

    var timerElement = document.getElementById("timer");
    timerElement.innerHTML = "00:00:00";
    var timer;

    startButton.addEventListener("click", function(event) {
      // starts timer
      console.log("start clicked");

      timer = setInterval(function() {
        var time = new Date();
        timerElement.innerHTML = time.toLocaleTimeString();
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
