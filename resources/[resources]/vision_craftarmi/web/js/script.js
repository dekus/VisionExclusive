function weaponToProduce(a) {
  fetch("https://" + GetParentResourceName() + "/getItem", {
    method: "POST",
    body: JSON.stringify({ modeName: String(a) }),
  });
}
const createItem = ({ name, type, image }) =>
  '\n  <div class="boxImg">\n    <img src="' + image + '" />\n  </div>\n  <div class="textBox">\n    <p>' + type + "</p>\n    <h3>" + name + "</h3>\n  </div>\n";
function createWeaponList(e) {
  document.querySelector(".leftBar").innerHTML = "";
  for (let f = 0; f < e.length; f++) {
    const g = document.createElement("div");
    g.classList.add("itemContent");
    g.innerHTML = createItem(e[f]);
    document.querySelector(".leftBar").appendChild(g);
    g.addEventListener("click", () => {
      document.querySelector(".centerBar").innerHTML = setWeaponInfos(e[f]);
    });
  }
}
function setWeaponInfos({ name, type, amount, image, ingredients }) {
  return ('\n    <div class="weaponInfos">\n<div class="centerImg">\n<img src="' +image +'"/>\n</div>\n<div class="textBox">\n<div class="textIncluse">\n<p>Nome</p>\n<h3>'+name+'</h3>\n</div>\n<div class="textIncluse">\n<p>Tipo</p>\n<h3>'+type +'</h3>\n</div>\n<div class="textIncluse">\n<p>Capacità di Munizioni</p>\n<h3>'+amount+'x</h3>\n</div>\n</div>\n</div>\n    <div class="makings">\n<p>COMPONENTI</p>\n</div>\n<div class="MakingBoxs">\n<div class="boxMakings">\n<img src="'+(ingredients[0] && ingredients[0].image)+'" onerror=\'this.style.display = "none"\'/>\n</div>\n<div class="boxMakings">\n        <img src="' + (ingredients[1] && ingredients[1].image) + '" onerror=\'this.style.display = "none"\'/>\n</div>\n<div class="boxMakings">\n<img src="'+(ingredients[2] && ingredients[2].image)+'" onerror=\'this.style.display = "none"\'/>\n</div>\n<div class="boxMakings">\n<img src="'+(ingredients[3] && ingredients[3].image) + '" onerror=\'this.style.display = "none"\'/>\n      </div>\n      <div class="boxMakings">\n        <img src="' + (ingredients[4] && ingredients[4].image) + '" onerror=\'this.style.display = "none"\'/>\n      </div>\n      <div class="boxMakings">\n        <img src="' + (ingredients[5] && ingredients[5].image) + '" onerror=\'this.style.display = "none"\'/>\n      </div>\n      <div class="boxMakings">\n        <img src="' + (ingredients[6] && ingredients[6].image) + '" onerror=\'this.style.display = "none"\'/>\n      </div>\n      <div class="boxMakings">\n        <img src="' + (ingredients[7] && ingredients[7].image) + '" onerror=\'this.style.display = "none"\'/>\n      </div>\n    </div>\n    <button onclick="weaponToProduce(\'' + name + "')\">Produrre</button>\n  ");
}
const search = document.querySelector("#search");
search.addEventListener("input", ({ target: m }) => {
  const q = config.filter((r) =>
    r.name.toLowerCase().includes(search.value.toLowerCase())
  );
  createWeaponList(q);
});
window.addEventListener("keyup", ({ key }) => {
  if (key === "Escape") {
    fetch("https://" + GetParentResourceName() + "/close", { method: "POST" });
    document.body.style.display = "none";
  }
});
window.addEventListener("message", ({ data }) => {
  if (data.action === "open") {
    createWeaponList(config);
    document.body.style.display = "flex";
  }
  if (data.action === "close") {
    document.body.style.display = "none";
  }
});
