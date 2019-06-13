let container;
let countries_name;

$(document).on("turbolinks:load", function(){
    $('.toggle-polla').click(function(){
        let polla_id = $(this).attr('id').replace('polla-', '');
        Rails.ajax({
            url: "/pollas/"+polla_id,
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

    buildGroup('A', first_round.slice(0, 4))
    buildGroup('B', first_round.slice(4, 8))
    buildGroup('C', first_round.slice(8, 12))

    for (i=1; i<9; i++){
        buildMatch($(".list-group-match#"+i+" .list-group.groups:last-child"), data.matches[i-1]);
    }

    $("input[type='number']").prop("disabled", true);
    container.find("button").addClass("disabled");
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
    const times = (data.length / 12);
    const data_return = [];
    for (g=0; g<3; g++){
        for (i=0; i<4; i++){
            data_return.push(data[i+times*4*g]);
        }
    }
    return data_return;
}

function buildMatch(element, match_info){
    console.log(match_info, match_info.result);
    let countries = [
                      {
                        name: match_info.country_1_name,
                        score: match_info.result_team_1
                      },
                      {
                        name: match_info.country_2_name,
                        score: match_info.result_team_2
                      },
                      match_info.result
                    ]

    element.children().each(function(i){
        changeFlag($(this).find(".flag-icon"), countries[i].name)
        $(this).find("span:nth-child(2)").html(countries_name[countries[i].name])
        $(this).find("input").val(countries[i].score);
        if (parseInt(countries[2]) == i+1){
            $(this).addClass('list-group-item-success');
        }
    })
}