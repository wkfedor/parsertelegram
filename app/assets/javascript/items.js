jQuery(function($){
    $("#startAction").click(function() {




        var timeleft = 500;
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


                    Object.entries(JSON.parse(xhr.responseText)).forEach((entry) => {
                        const [key, value] = entry;
                        if(key=='d')
                        {

                            for(var i=0;i<value.length;i++)
                            {
                                console.log('d: '+  value[i]['username'] + value[i]['title'] + value[i]['description'] );
                            }

                        }
                        else
                        {
                            console.log(key + ': ' + value);
                        }

                    });


                    $('#dialog_title_span').text( JSON.parse(xhr.responseText));
                    $('#dialog_title_span2').text(timeleft);
                }
            })

            timeleft -= 1;
        }, 1000)





    });
});