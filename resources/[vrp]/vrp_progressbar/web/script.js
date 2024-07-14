window.addEventListener("message", ({data}) => {
  $("body").css("display","flex")
  $("#info p").html(data.action)
  let progress = 0;
  let interval = setInterval(() => {
    progress += 1;
    updateCircle(progress)
    if (progress >= 100) {
      clearInterval(interval);
    }
  }, data.delay / 100);
  setTimeout(() => {
    $("body").fadeOut(500)
  }, data.delay)
})

const updateCircle = (percent) => {
  const progressCircle = document.querySelector(".circle");
  const circumference = progressCircle.r.baseVal.value * 2 * Math.PI;
  $(progressCircle).css("stroke-dasharray", circumference);
  if (percent) {
    $(progressCircle).css("stroke-dashoffset",circumference - (percent / 100) * circumference);
    $(".circle-percent").html(percent + "%")
  }
}