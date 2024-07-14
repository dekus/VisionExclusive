
let sectionStatus = true
let vehicles = {}
let carSelectedCategory = null
let carSelectedVeh = null

/* PAGINAS DA CONCE */
let totalPage = 10
let pagina = 0
let key = null
let currentCategory = null

const app = {
    modalPage: true,
    modalStatus: true, 
    open: () => {
        $('body').show();
        $("#search").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $(".content-vehicles .item").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
        app.carPagination();
        app.changeCategory("macchine");
    },
    close: (status) => {
        key = null
        if (status) { 
            $.post("https://dealership/close", JSON.stringify({}));
        }
        $('body').hide();
        window.location.reload();
    },
    openSections: (element) => {
        $('.sellVeh').hide();
        $('.time-info').show();
        $('.options').hide('slow');
        app.changeCategory("macchine");
    },
    updateCars: (value) => {
        key = null
        $('.options').hide('slow');
        $('.content-vehicles').empty();
        $.post('https://dealership/requestVeh',JSON.stringify({ category : value }), (v) => {
            key = Object.keys(v);
            currentCategory = value

            for (var i = pagina * totalPage; i < key.length && i < (pagina +1) * totalPage; i++) {
                $('.content-vehicles').append(`
                    <div class="item"
                        data-img="https://images.visionexclusive.it/veicoli/${v[Object.keys(v)[i]].spaw}.png"
                        data-price="${v[Object.keys(v)[i]].valor}" data-estoque="${v[Object.keys(v)[i]].estoque}" 
                        data-veh="${v[Object.keys(v)[i]].spaw}" data-weight="${v[Object.keys(v)[i]].peso}" data-category="${value}" data-name="${v[Object.keys(v)[i]].nome}" 
                        onclick="app.selectCar(this)"
                    >
                        <div class="title">
                        <small>Veicolo</small>
                        <span>${v[Object.keys(v)[i]].nome}</span>
                        </div>
                        <img src="https://images.visionexclusive.it/veicoli/${v[Object.keys(v)[i]].spaw}.png">
                        <button>Visualizzare</button>
                    </div>
                `)
            }
            app.updateButtons();
            $('#currentPage').text((pagina +1) + ' di ' + Math.ceil(key.length / totalPage))
        });
    },
    updateButtons: () => {
        $('#next').prop('disabled', key.length <= totalPage || pagina >= Math.ceil(key.length / totalPage) -1);
        $('#prev').prop('disabled', key.length <= totalPage || pagina == 0);
    },
    carPagination: () => {
        $('#next').click(function() {
            if (pagina < key.length / totalPage - 1) {
                pagina++
                app.updateButtons();
                app.updateCars(currentCategory);
            }
        });
        $('#prev').click(function() {
            if (pagina > 0) {
                pagina--
                app.updateButtons();
                app.updateCars(currentCategory);
            }
        });
    },
    sellCars: () => {
        $('.buyVeh').hide();
        $('.testDrive').hide();
        $('.sellVeh').show();
        $('.content-vehicles').empty();
        $.post('https://dealership/updateSellVeh',JSON.stringify({}),(data) => {
            $.each(data.vehicle,function(k,v){
                $('.content-vehicles').append(`
                    <div class="item"
                        data-img="https://images.visionexclusive.it/veicoli/${v.spawn}.png" data-estoque="1" 
                        data-price="${v.price}" data-veh="${v.spawn}" data-category="${v.category}"
                        onclick="app.selectCar(this)"
                    >
                        <div class="title">
                        <small>Veicolo</small>
                        <span>${v.name}</span>
                        </div>
                        <img src="https://images.visionexclusive.it/veicoli/${v.spawn}.png">
                        <button>Visualizzare</button>
                    </div>
                `);
            });
        });
    },
    sellVehicle: (element) => {
        $.post("https://dealership/sellVehicle", JSON.stringify({ vehicle: element.dataset.veh, price: element.dataset.price  }));
    },
    buyVehicle: () => {
        $.post("https://dealership/buyVehicle", JSON.stringify({
            category: carSelectedCategory,
            vehicle: carSelectedVeh,
            payment: "avista",
        }));
    },
    testDrive: (element) => {
        $.post("https://dealership/startTest", JSON.stringify({
            category: element.dataset.category,
            vehicle: element.dataset.veh
        }));
    },
    changeCategory: (value) => {
        pagina = 0
        $('#categoryName').html(value)
        app.updateCars(value);
    },
    selectCar: (element) => {
        $('aside').show('slow');
        $('section').css('filter', 'blur(2px)');
        $('.item').css('pointer-events', 'none');

        carSelectedVeh = element.dataset.veh
        carSelectedCategory = element.dataset.category

        $('#name-car').html(element.dataset.name);
        $('#price-car').html('$ '+element.dataset.price);
        $('#qtd-car').html(element.dataset.estoque);
        $('#portamalaCar').html( element.dataset.weight);

        $('#category-name').html(carSelectedCategory);
        $('.img-car').attr('src', element.dataset.img);

        $('.testDrive').attr('data-veh', element.dataset.veh);
        $('.testDrive').attr('data-category', carSelectedCategory);
        $('.buyVeh').attr('data-veh', element.dataset.veh);
        $('.buyVeh').attr('data-price', element.dataset.price);

        $('.sellVeh').attr('data-veh', element.dataset.veh);
        $('.sellVeh').attr('data-price', element.dataset.price);
    },
    filterPrice: (minPrice,maxPrice) => {
        $(".content-vehicles .item").hide().filter(function() {
            var price = parseInt($(this).data("price"), 10);
            return price >= minPrice && price <= maxPrice;
        }).show();
    },
    changePrice: () => {
        let maxValue = $('#inputMax').val();
        let minValue = $('#inputMin').val();
        app.filterPrice(minValue,maxValue);
    },
    cancelBuy: () => {
        $('aside').fadeOut();
        $('section').css('filter', 'blur(0px)');
        $('.item').css('pointer-events', 'all');
    }
}

window.addEventListener("message",function(event){
	if (event.data.action !== "" ) { 
        switch(event.data.action) {
            case "open":
                app.open();
                $('#name').html(event["data"]["infos"][0] +' '+ event["data"]["infos"][1] );
                // $('#wallet-value').html(event["data"]["infos"][2]);
                $('#bank-value').html(event["data"]["infos"][3]);
            break;

            case "close":
                app.close();
            break;
        }

        document.onkeyup = data => {
            const key = data.key;
            if (key === "Escape") {
                $.post("https://dealership/close", JSON.stringify({}));
            }
        };
    }
});


let masterIo = true
function openCategorys() {
    if (masterIo) {
        masterIo = false
        $('.options').show('slow');
    } else {
        masterIo = true
        $('.options').hide('slow');
    }
}

/* let devtools = function() {};


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
 */