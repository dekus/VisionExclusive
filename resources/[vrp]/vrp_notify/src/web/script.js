const icons = {
  successo: "./assets/sucesso.svg",
  negato: "./assets/negado.svg",
  importante: "./assets/importante.svg",
  avviso: "./assets/aviso.svg",
  finanziario: "./assets/financeiro.svg",
  airdrop: "./assets/airdrop.svg",
};

function eventListener({ data }) {
  if (!data) return;

  const { type, delay, message } = data;

  AOS.init();
  const icon = icons[type] ? icons[type] : icons["avviso"];
  const nRandom = ~~(Math.random() * 1000 + 1);

  const classNotify = `notify-${nRandom}`;

  const html = `
    <div class="notify ${classNotify}" id="${icons[type] ? type : "avviso"}" data-aos="fade-left" data-aos-easing="ease-out-cubic">
      <div class="iconWrapper">
        <img src="${icon}">
      </div>
      <content>
        <small>${icons[type] ? type : "Allerta"}</small>
        <p>${message}</p>
      </content>
      <div class="progress">
        <div class="value" style="animation: progress ${delay}ms;"></div>
      </div>
    </div>
  `;

  $(html).appendTo("main");

  setTimeout(() => {
    $(`.${classNotify}`).css("animation", "hide 500ms");
    setTimeout(() => {
      $(`.${classNotify}`).remove();
    }, 500);
  }, delay);
}

window.addEventListener("message", eventListener);
