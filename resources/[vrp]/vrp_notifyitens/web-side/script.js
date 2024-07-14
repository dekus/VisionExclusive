let icons = {
  ricevuto: "./assets/recebido-point.svg",
  rimosso: "./assets/removido-point.svg"
}

function eventListener({ data }) {
  if (!data) return;
  const { type, name, image, amount } = data;
  const icon = icons[type]
  AOS.init();
  const nRandom = ~~(Math.random() * 1000 + 1);
  const descriminator = nRandom * 2
  const html = `<div class="container" descriminator="${descriminator}" id="${type}" data-aos="fade-left" data-aos-easing="ease-out-cubic">
  <div class="left">
    <small>item</small>
    <p><img src="${icon}"/> ${name}</p>
  </div>
  <div class="right">
    <img src="https://images.visionexclusive.it/images/${image}.png"/>
    <p>${amount}x <span>${type}</span></p>
  </div>
</div>`;
  $(html).appendTo("#notifys-wrapper");
  setTimeout(() => {
    $("[descriminator='"+descriminator+"']").css("animation","hide 500ms");
    setTimeout(() => {
      $("[descriminator='"+descriminator+"']").remove();
      $(`.${descriminator}`).remove();
    }, 500);
  }, 5000);
}
window.addEventListener("message", eventListener);
