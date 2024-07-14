const app = {
  notifyKill: ({ assassin, victim, weapon }) => {
    AOS.init();
    const notify = document.createElement("div");
    $(notify)
      .attr("id", "notify")
      .html(
        `
    <p><span>${assassin.id}</span> ${assassin.name}</p>
    <img src="./assets/${weapon}.png"/>
    <p>${victim.name} <span>${victim.id}</span></p>`
      )
      .css("animation", "showKill .3s");
    $("#notifyContainer").append(notify);
    setTimeout(() => $(notify).css("animation", "hideKill 1s"), 3000);
    setTimeout(() => $(notify).remove(), 3500);
  },
};

window.addEventListener("message", ({ data }) => {
  app.notifyKill(data);
});
