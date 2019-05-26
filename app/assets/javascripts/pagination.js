$(document).on("turbolinks:load", function(){
    $('.page-item').on('click touch', function() {
        if (!$(this).hasClass("disabled")){
            $('.page-item').removeClass("active");
            let id = $(this).attr('id');
            $(this).addClass("active");
            $('.container-page').hide();
            $('.container-page#'+id+"-page").css({"display": "flex"});
            if ($(this).is("#group-phase")){
                $('#quarter-finals').removeClass("disabled");
            }
            if ($(this).is("#quarter-finals")){
                $('#semifinals').removeClass("disabled");
            }
            if ($(this).is("#semifinals")){
                $('#finals').removeClass("disabled");
            }
        }
    })
});
