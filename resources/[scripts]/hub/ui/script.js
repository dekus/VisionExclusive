let elements = [];
var resourceName = GetParentResourceName();
const Hub = {
  requestsCount: 0,
  notificationsCount: 0,
  muted: false,
  toggle: function (open) {
    if (open) $("main").fadeIn();
    else $("main").fadeOut();
  },
  toggleMuted: function () {
    if (Hub.muted) {
      Hub.muted = false;
      document.querySelector('footer').innerHTML = `
      <i class='fa-solid fa-volume'></i>
      <p>
        <b>alertas na tela</b>
        <span>pressione <strong>[tab]</strong> para <strong id="ouvir">silenciar</strong> as notificações</span>
      </p>
      `;
    } else {
      Hub.muted = true;
      document.querySelector('footer').innerHTML = `
      <i class='fa-solid fa-volume-slash'></i>
      <p>
        <b>alertas na tela</b>
        <span>pressione <strong>[tab]</strong> para <strong id="ouvir">ouvir</strong> as notificações</span>
      </p>
      `;
    }
  },
  addTemporaryNotification: function (title, description, persistent) {
    let temporaryId = Date.now();
    let persistentClass = "";

    if (persistent) persistentClass = " will-be-persistent";
    if (!Hub.muted) {
      let elementTemporary = `
          <div class="notify hub-notification${persistentClass}" id="notification-${temporaryId}" hidden>
              <i class="fa-solid fa-bells"></i>
              <div class="text">
                  <span><b>${title}</b></span>
                  <p>${description}</p>
              </div>
          </div>`;
      $("#hub-tray").prepend(elementTemporary);
      $("#notification-" + temporaryId).fadeIn(200, function () {
        setTimeout(function () {
          $("#notification-" + temporaryId).fadeOut(200, function () {
            $("#notification-" + temporaryId).remove();
          });
        }, 5000);
      });
      Hub.playAudio();
    };
  },

  addRequest: function (title, description, id) {
    Hub.addTemporaryNotification(title, description, true);
    let date = Hub.getDate();
    let element = `
        <div class="item hub-notification" request-id="${id}">
            <div class="info-item">
                <small>${title} - ${date}</small>
                <p>${description}</p>
            </div>
            <div class="actions-item">
                <button class="hub-notification-option-accept" onclick="Hub.tryAcceptRequest(this)"><i class="fa-solid fa-check"></i></button>
                <button class="hub-notification-option-remove" onclick="Hub.denyRequest(this)"><i class="fa-solid fa-xmark"></i></button>
            </div>
        </div>`;

    $("#hub-empty").fadeOut();
    if (Hub.requestsCount == 0) {
      if (Hub.notificationsCount > 0)
        $("#hub").removeClass("lists-1").addClass("lists-2");
        $("[notification-type='request']").fadeIn();
    }

    $(".hub-notifications[notification-type='request']").prepend(element);
    Hub.requestsCount++;
  },
  tryAcceptRequest: function (element) {
    if ($(element).parent().parent().hasClass("hub-notification-accepted"))
      return false;
    let requestId = $(element).parent().parent().attr("request-id");
    elements[parseInt(requestId)] = element;
    $.post(
      `http://${resourceName}/tryAcceptRequest`,
      JSON.stringify({ id: requestId })
    );
    $(element).parent().parent().remove();
  },
  deleteRequest: function (id) {
    const Element = document.querySelectorAll(".item");
    Element.forEach((i) => {
      if (id == i.getAttribute("request-id")) {
        i.remove();
      }
    });
  },
  denyRequest: function (element) {
    $(element)
      .parent()
      .parent()
      .fadeOut(200, function () {
        $(element).parent().parent().remove();
      });

    Hub.requestsCount--;

    if (Hub.requestsCount == 0) {
      $("[notification-type='request']").fadeOut(200, function () {
        $("#hub").removeClass("lists-2").addClass("lists-1");
      });

      if (Hub.notificationsCount == 0) $("#hub-empty").fadeIn();
    }
  },
  setAcceptedRequest: function (requestId, playerId) {
    if (playerId == "ok") {
      $(".hub-notification[request-id='" + requestId + "']")
        .addClass("hub-notification-accepted")
        .children(".hub-notification-options")
        .removeClass("options-2")
        .addClass("options-1")
        .children(".hub-notification-option-accept")
        .remove();
    } else {
      $(".hub-notification[request-id='" + requestId + "']")
        .children(".hub-notification-options")
        .children(".hub-notification-option-accept")
        .addClass("hub-notification-option-accepted")
        .removeClass("hub-notification-option-accept")
        .html("Atendido por " + playerId);

      setTimeout(function () {
        $(".hub-notification[request-id='" + requestId + "']")
          .children(".hub-notification-options")
          .children(".hub-notification-option-remove")
          .trigger("click");
      }, 20000);
    }
  },
  playAudio: function () {
    if (!Hub.muted) $("#hub-audio")[0].play();
  },
  getDate: function () {
    let date = new Date();
    const [h, m, D, M] = [
      date.getHours(),
      date.getMinutes(),
      date.getDate(),
      date.getMonth() + 1,
    ]
      .map(String)
      .map((s) => s.padStart(2, 0));
    return `${h}:${m} ${D}/${M}`;
  },
};

function openNotifys() {
  $(".notify-content").is(":visible")
    ? $(".notify-content").hide("slow")
    : $(".notify-content").show("slow");
}

window.addEventListener("message", function ({data}) {
  switch (data.action) {
    case "open":
      Hub.toggle(true);
      break;
    case "addRequest":
      Hub.addRequest(
        data.title,
        data.description,
        data.id
      );
      break;
    case "setAcceptedRequest":
      Hub.setAcceptedRequest(data.id, data.user_id);
      break;
    case "deleteRequest":
      Hub.deleteRequest(data.delete);
  }
});

window.onkeyup = function (data) {
  if (data.which == 27) {
    Hub.toggle(false);
    $(".notify-content").hide("slow");
    $.post(`http://${resourceName}/close`, JSON.stringify({}));
  } else if (data.which == 9) {
    Hub.toggleMuted();
  }
};
