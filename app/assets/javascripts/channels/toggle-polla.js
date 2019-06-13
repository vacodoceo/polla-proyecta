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
    console.log(data);
    $(".modal-title").html(data.name);
    container = $(".container-pagination");
    countries_name = data.countries_name;
    build_group('A', data.first_round.slice(0, 4))
    build_group('B', data.first_round.slice(4, 8))
    build_group('C', data.first_round.slice(8, 12))
}

function build_group(id, countries){
    let group = container.find("#"+id+" .list-group.groups:last-child");
    group.children().each(function(i){
        group_assign($(this), countries[i].country_name);
    })
}

function group_assign(element, country){
    change_flag(element.find(".flag-icon"), country)
    element.find(".country-name").html(countries_name[country])
}

function change_flag(element, country){
    element.removeClass();
    element.addClass("flag-icon flag-icon-"+country);
}