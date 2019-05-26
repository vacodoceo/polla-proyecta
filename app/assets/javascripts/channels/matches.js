let groups = { 'A': [], 'B':[], 'C':[] };
let quarter_finals = {};
let semifinals = {}
let finals = {} 

$(document).on("turbolinks:load", function(){
    $(".sortable").sortable();

    handleGroups();

    handleCountrySelect(1);
    handleCountrySelect(4);

    handleWinner();

    $("input[type='number']").inputSpinner();

    
});

function handleGroups(){
    $(".sortable").on( "sortupdate", function() {
        groups = { 'A': [], 'B':[], 'C':[] };
        for (i=0; i<Object.keys(groups).length; i++){
            for (j=0; j<4; j++){
                let group = Object.keys(groups)[i];
                groups[group].push($('#'+group+' .sortable li:nth-child('+(j+1)+')').attr('id'));
            }
        }

        // console.log(groups);

        addCountry(1, groups['A'][0], [groups['C'][2], groups['B'][2]]);
        addCountry(2, groups['B'][0], groups['C'][1]);
        addCountry(3, groups['A'][1], groups['B'][1]);
        addCountry(4, groups['C'][0], [groups['A'][2], groups['B'][2]]);
        checkWinners();
    } );
}

function addCountry(match, c1, c2){
    let c1_name = $('#'+c1+' .country-name').text();
    $('#'+match.toString()+' .groups li:nth-child(1) span:first-child').removeClass();
    $('#'+match.toString()+' .groups li:nth-child(1) span:first-child').addClass('flag-icon flag-icon-'+c1);
    $('#'+match.toString()+' .groups li:nth-child(1)').attr('country', c1);
    $('#'+match.toString()+' .groups li:nth-child(1) span:nth-child(2)').html(c1_name);
    if (match == 1 || match == 4){
        $('#'+match.toString()+' .groups li:nth-child(2) .select-country').children().each(function(i) {
            if (i == 1){
                $(this).parent().parent().children('span').removeClass();
                $(this).parent().parent().children('span').addClass('flag-icon flag-icon-'+c2[0]);
            }
            $(this).attr('value', c2[i]);
            $(this).addClass(c2[i]);
            $(this).html($('#'+c2[i]+' .country-name').text());
        })
    }
    else {
        let c2_name = $('#'+c2+' .country-name').text();
        $('#'+match.toString()+' .groups li:nth-child(2) span:first-child').removeClass();
        $('#'+match.toString()+' .groups li:nth-child(2) span:first-child').addClass('flag-icon flag-icon-'+c2);
        $('#'+match.toString()+' .groups li:nth-child(2)').attr('country', c2);
        $('#'+match.toString()+' .groups li:nth-child(2) span:nth-child(2)').html(c2_name);
    }
}

function handleCountrySelect(match){
    $('#'+match.toString()+ ' .select-country').change(function() {
        $('#'+match.toString()+' .groups li:nth-child(2) span:first-child').removeClass();
        $('#'+match.toString()+' .groups li:nth-child(2) span:first-child').addClass('flag-icon flag-icon-'+$(this).val());
        $('#'+match.toString()+' .groups li:nth-child(2)').attr('country', $(this).val());
        other_match = (match == 1) ? 4 : 1;
        $('#'+other_match.toString()+' .groups li:nth-child(2) .select-country option').css({ 'display': ''});
        $('#'+other_match.toString()+' .groups li:nth-child(2) .select-country .'+$(this).val()).hide();
        checkWinners();
        }
    )
}

function handleWinner(){
    $('input#number').on("change", function () {
        let country1 = $(this).parent().parent().children('li:nth-child(1)'); 
        let country2 = $(this).parent().parent().children('li:nth-child(2)'); 
        let standings = country1.parent().parent().children('.standings');
        if (country1.children('input#number').val() > country2.children('input#number').val()){
            country1.addClass('list-group-item-success');
            country2.removeClass('list-group-item-success');
            standings.children().children().addClass('disabled');
            standings.children('li:nth-child(2)').children().removeClass('btn-success');
            standings.children('li:nth-child(2)').children().addClass('btn-outline-success');
            standings.children('li:nth-child(1)').children().removeClass('btn-outline-success');
            standings.children('li:nth-child(1)').children().addClass('btn-success');
        }
        else if (country1.children('input#number').val() < country2.children('input#number').val()){
            country2.addClass('list-group-item-success');
            country1.removeClass('list-group-item-success');
            standings.children().children().addClass('disabled');
            standings.children('li:nth-child(1)').children().removeClass('btn-success');
            standings.children('li:nth-child(1)').children().addClass('btn-outline-success');
            standings.children('li:nth-child(2)').children().removeClass('btn-outline-success');
            standings.children('li:nth-child(2)').children().addClass('btn-success');
        }
        else {
            country1.removeClass('list-group-item-success');
            country2.removeClass('list-group-item-success');
            standings.children().children().removeClass('disabled');
            standings.children().children().removeClass('btn-success');
            standings.children().children().addClass('btn-outline-success');
        }
        checkWinners();
    })

    $('.button-winner').click(function () {
        if (!$(this).hasClass('disabled')){
            $(this).removeClass('btn-outline-success');
            $(this).addClass('btn-success');
            let my_pos = (parseInt($(this).attr('id'))).toString();
            let other_pos = (3 - parseInt($(this).attr('id'))).toString();
            $(this).parent().parent().children('li:nth-child('+other_pos+')').children().removeClass('btn-success');
            $(this).parent().parent().children('li:nth-child('+other_pos+')').children().addClass('btn-outline-success');

            $(this).parent().parent().parent().children('ul:nth-child(2)').children('li:nth-child('+my_pos+')').addClass('list-group-item-success');
            $(this).parent().parent().parent().children('ul:nth-child(2)').children('li:nth-child('+other_pos+')').removeClass('list-group-item-success');
        }
        checkWinners();
    })

}

function checkWinners(){
    let open_semifinals = 1;
    for (i=1; i<5; i++){
        let success = 0;
        $('ul#'+i.toString()+' ul:nth-child(2)').children().each(function() {
            if ($(this).hasClass('list-group-item-success')) {
                quarter_finals[i] = $(this).attr('country');
                success = 1;
            }
        })
        if (!success){
            open_semifinals = 0;
            break;
        };
    }
    if (!open_semifinals){
        $('#semifinals').addClass('disabled')
    }
    else {
        let c1_name = $('#'+quarter_finals[1]+' .country-name').text();
        let c2_name = $('#'+quarter_finals[2]+' .country-name').text();
        let c3_name = $('#'+quarter_finals[3]+' .country-name').text();
        let c4_name = $('#'+quarter_finals[4]+' .country-name').text();
        $('#semifinals').removeClass('disabled')
        $('#5 .groups li:nth-child(1) span:first-child').removeClass();
        $('#5 .groups li:nth-child(1) span:first-child').addClass('flag-icon flag-icon-'+quarter_finals[1]);
        $('#5 .groups li:nth-child(1)').attr('country', quarter_finals[1]);
        $('#5 .groups li:nth-child(1) span:nth-child(2)').html(c1_name);
        $('#5 .groups li:nth-child(2) span:first-child').removeClass();
        $('#5 .groups li:nth-child(2) span:first-child').addClass('flag-icon flag-icon-'+quarter_finals[3]);
        $('#5 .groups li:nth-child(2)').attr('country', quarter_finals[3]);
        $('#5 .groups li:nth-child(2) span:nth-child(2)').html(c3_name);
        $('#6 .groups li:nth-child(1) span:first-child').removeClass();
        $('#6 .groups li:nth-child(1) span:first-child').addClass('flag-icon flag-icon-'+quarter_finals[2]);
        $('#6 .groups li:nth-child(1)').attr('country', quarter_finals[2]);
        $('#6 .groups li:nth-child(1) span:nth-child(2)').html(c2_name);
        $('#6 .groups li:nth-child(2) span:first-child').removeClass();
        $('#6 .groups li:nth-child(2) span:first-child').addClass('flag-icon flag-icon-'+quarter_finals[4]);
        $('#6 .groups li:nth-child(2)').attr('country', quarter_finals[4]);
        $('#6 .groups li:nth-child(2) span:nth-child(2)').html(c4_name);
        let open_finals = 1;
        for (i=5; i<7; i++){
            success = 0;
            $('ul#'+i.toString()+' ul:nth-child(2)').children().each(function() {
                if ($(this).hasClass('list-group-item-success')) {
                    semifinals[1+(i-5)*2] = $(this).attr('country');
                    success = 1;
                }
                else {
                    semifinals[2+(i-5)*2] = $(this).attr('country');
                }
            })
            if (!success){
                open_finals = 0;
                break;
            };
        }
        if (!finals){
            $('#semifinals').addClass('disabled')
        }
        else {
        let c5_name = $('#'+semifinals[1]+' .country-name').text();
        let c6_name = $('#'+semifinals[2]+' .country-name').text();
        let c7_name = $('#'+semifinals[3]+' .country-name').text();
        let c8_name = $('#'+semifinals[4]+' .country-name').text();
        $('#finals').removeClass('disabled')
        $('#7 .groups li:nth-child(1) span:first-child').removeClass();
        $('#7 .groups li:nth-child(1) span:first-child').addClass('flag-icon flag-icon-'+semifinals[2]);
        $('#7 .groups li:nth-child(1)').attr('country', semifinals[2]);
        $('#7 .groups li:nth-child(1) span:nth-child(2)').html(c6_name);
        $('#7 .groups li:nth-child(2) span:first-child').removeClass();
        $('#7 .groups li:nth-child(2) span:first-child').addClass('flag-icon flag-icon-'+semifinals[4]);
        $('#7 .groups li:nth-child(2)').attr('country', semifinals[4]);
        $('#7 .groups li:nth-child(2) span:nth-child(2)').html(c8_name);
        $('#8 .groups li:nth-child(1) span:first-child').removeClass();
        $('#8 .groups li:nth-child(1) span:first-child').addClass('flag-icon flag-icon-'+semifinals[1]);
        $('#8 .groups li:nth-child(1)').attr('country', semifinals[1]);
        $('#8 .groups li:nth-child(1) span:nth-child(2)').html(c5_name);
        $('#8 .groups li:nth-child(2) span:first-child').removeClass();
        $('#8 .groups li:nth-child(2) span:first-child').addClass('flag-icon flag-icon-'+semifinals[3]);
        $('#8 .groups li:nth-child(2)').attr('country', semifinals[3]);
        $('#8 .groups li:nth-child(2) span:nth-child(2)').html(c7_name);
        }
    }
}