let groups = { 'A': [], 'B':[], 'C':[] };

$(document).on("turbolinks:load", function(){
    $(".sortable").sortable();

    handleGroups();

    handleCountrySelect(1);
    handleCountrySelect(4);

    $("input[type='number']").inputSpinner();

    
});

function handleGroups(){
    $(".sortable").on( "sortupdate", function( event, ui ) {
        groups = { 'A': [], 'B':[], 'C':[] };
        for (i=0; i<Object.keys(groups).length; i++){
            for (j=0; j<4; j++){
                let group = Object.keys(groups)[i];
                groups[group].push($('#'+group+' .sortable li:nth-child('+(j+1)+')').attr('id'));
            }
        }

        addCountry(1, groups['A'][0], [groups['C'][2]], groups['B'][2]);
        addCountry(2, groups['B'][0], groups['C'][1]);
        addCountry(3, groups['A'][1], groups['B'][1]);
        addCountry(4, groups['C'][0], [groups['A'][2], groups['B'][2]]);
    } );
}

function addCountry(group, c1, c2){
    let c1_name = $('#'+c1+' .country-name').text();
    $('#'+group.toString()+' li:nth-child(2) span:first-child').removeClass();
    $('#'+group.toString()+' li:nth-child(2) span:first-child').addClass('flag-icon flag-icon-'+c1);
    $('#'+group.toString()+' li:nth-child(2) span:nth-child(2)').html(c1_name);
    if (group == 1 || group == 4){
        $('#'+group.toString()+' li:nth-child(3) .select-country')
            .find('option')
            .remove()
            .end()
            .append('<option value="'+c2[0]+'">'+$('#'+c2[0]+' .country-name').text()+'</option>');
    }
    else {
        let c2_name = $('#'+c2+' .country-name').text();
        $('#'+group.toString()+' li:nth-child(3) span:first-child').removeClass();
        $('#'+group.toString()+' li:nth-child(3) span:first-child').addClass('flag-icon flag-icon-'+c2);
        $('#'+group.toString()+' li:nth-child(3) span:nth-child(2)').html(c2_name);
    }
}

function handleCountrySelect(group){
    $('#'+group.toString()+ ' .select-country').change(function() {
        $('#'+group.toString()+' li:nth-child(3) span:first-child').removeClass();
        $('#'+group.toString()+' li:nth-child(3) span:first-child').addClass('flag-icon flag-icon-'+$(this).val());
        other_group = (group == 1) ? 4 : 1;
        $('#'+other_group.toString()+' li:nth-child(3) .select-country option').css({ 'display': ''});
        $('#'+other_group.toString()+' li:nth-child(3) .select-country .'+$(this).val()).hide();
        }
    )    
}