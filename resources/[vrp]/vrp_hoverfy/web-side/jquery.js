$(document).ready(function () {
  window.addEventListener("message", function (event) {
    if (event["data"]["show"] == true) {
      var key =
        event["data"]["key"] !== undefined
          ? `<div id="key">${event["data"]["key"]}</div>`
          : "";
      $("#hoverfy").html(
        key +
          `<div id="content">
				<small>
        ${event["data"]["prefix"]}
				</small>
				<p>${event["data"]["action"]} <span>${event["data"]["title"]}</span></p>
			</div>`
      );
      $("body").css("display","flex");
    }
    if (event["data"]["show"] == false) {
      $("body").fadeOut(250);
    }
  });
});
