jQuery(function($){
    $("#startAction").click(function() {




        var timeleft = 50;
        var downloadTimer = setInterval(function(){
            if(timeleft <= 0){
                clearInterval(downloadTimer);
            }
            //$('#dialog_title_span').text ( 10 - timeleft);

            $.ajax({
                url: "/onlinestatupdatedb",
                type: "POST",
                data: {_method: 'START'},
                success: function(data, textStatus, xhr) {
                    $('#dialog_title_span').text(xhr.responseText);
                    $('#dialog_title_span2').text(timeleft);
                }
            })

            timeleft -= 1;
        }, 1000)





    });
});