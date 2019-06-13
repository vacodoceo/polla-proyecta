let container;
let countries_name;

$(document).on("turbolinks:load", function(){
    $('.toggle-polla').click(function(){
        Rails.ajax({
            url: "/pollas/"+$(this).attr('id'),
            type: "get",
            success: function(data) { build_polla(data) }
        })
    });
})

function build_polla(data){
    $(".modal-title").html(data.name);
    container = $(".container-pagination");
    countries_name = data.countries_name;
    let first_round = handleBuggedData(data.first_round);

    buildGroup('A', data.first_round.slice(0, 4))
    buildGroup('B', data.first_round.slice(4, 8))
    buildGroup('C', data.first_round.slice(8, 12))
}

function buildGroup(id, countries){
    let group = container.find("#"+id+" .list-group.groups:last-child");
    group.children().each(function(i){
        groupAssign($(this), countries[i].country_name);
    })
}

function groupAssign(element, country){
    changeFlag(element.find(".flag-icon"), country)
    element.find(".country-name").html(countries_name[country])
}

function changeFlag(element, country){
    element.removeClass();
    element.addClass("flag-icon flag-icon-"+country);
}

function handleBuggedData(data){
    const times = (data.size() / 12) - 1;
    console.log(times);
}