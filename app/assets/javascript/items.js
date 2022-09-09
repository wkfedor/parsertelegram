jQuery(function($){
    $("#startAction").click(function() {

        var timeleft = 1000;
        //$('#dialog_title_span4').text("в течении "+timeleft+" данные на странице будут обновляться автоматически");
        var downloadTimer = setInterval(function(){
            if(timeleft <= 0){
                clearInterval(downloadTimer);
            }
            //$('#dialog_title_span').text ( 10 - timeleft);


            // запрос ниже запускаем при следующих условиях
            // однократно нажали на кнопку старт. далее запрос не запускаем
           // alert($('#buttonsstart').value);
            if($('#buttonsstart').val()=="no")
            {
              $.ajax({
                url: "/workdbavto",
                type: "post",
                data: {_method: 'START'}
             });
                $('#buttonsstart').val("yes");
            }




            $.ajax({
                url: "/onlinestatupdatedb",
                type: "POST",
                data: {_method: 'START'},
                success: function(data, textStatus, xhr) {

                    var temp='';
                    var temp2='';
                    var a='';
                    var b='';
                    var c='';
                    Object.entries(JSON.parse(xhr.responseText)).forEach((entry) => {
                        const [key, value] = entry;

                        if(key=='d')
                        {
                            for(var i=0;i<value.length;i++)
                            {
                                //console.log('d: '+  value[i]['username'] + value[i]['title'] + value[i]['description'] );
                                temp += "<tr><td>" + value[i].username + "<\/td><td>" + value[i].title + "<\/td><td>" + value[i].description + "<\/td><\/tr>";

                            }
                        }
                        else if(key=='a')
                        {
                            a= value
                        }
                        else if(key=='b')
                        {
                            b= value
                        }
                        else if(key=='c')
                        {
                            c= value
                        }
                        else if(key=='e')
                        {
                            for(var i=0;i<value.length;i++)
                            {
                                temp2 += "<tr><td>" + value[i].word + "<\/td><td>" + value[i].flag + "<\/td><td>" + value[i].updated_at + "<\/td><\/tr>";
                                //console.log('e: '+  value[i]['word'] + value[i]['flag'] + value[i]['updated_at'] );
                            }
                        }
                        else
                        {
                            console.log(key + ': ' + value);
                        }

                    });
                    //console.log(temp);



                    temp3='значение {"Необработано":'+a+',"В работе":'+b+',"Ненайдено":'+c+'}'
                    $('#dialog_title_span').html(temp3);
                    $('#dialog_title_span2').html('<table class="table"><thead class="thead-dark"><tr><th scope="col">Имя</th><th scope="col">Заголовок</th><th scope="col">Описание</th></tr></thead><tbody>'+temp+'</tbody></table>');
                    $('#dialog_title_span3').html('<table class="table"><thead class="thead-dark"><tr><th scope="col">Имя</th><th scope="col">флаг</th><th scope="col">время</th></tr></thead><tbody>'+temp2+'</tbody></table>');
                    $('#dialog_title_span4').text(timeleft);
                }
            })

            timeleft -= 1;
        }, 500)





    });
});