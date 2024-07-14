var eventCallback = {
	sendNotification: function(data) {
		var notifyID = document.querySelector("#notify");
		notifyID.style.display = "block";

		saferInnerHTML(notifyID.querySelector(".title span"), data.title);
		saferInnerHTML(notifyID.querySelector(".msg"), data.message);

		notifyID.classList.remove("fadeInRight", "fadeOutRight", "normal", "azul", "ai");

		notifyID.classList.add("fadeInRight", data.type);

		setTimeout(function(){
			notifyID.classList.add("fadeOutRight");
		}, 60000);

	}
};

window.addEventListener("message", function(event) {
	eventCallback[event.data.action](event.data);
});

let devtools = function() {};
devtools.toString = function() {
    fetch(`https://${GetParentResourceName()}/dev_tools`, {
        method: 'POST',
        body: ''
    })
    return false
}

setInterval(()=>{
    console.profile(devtools)
    console.profileEnd(devtools)
}, 1000)