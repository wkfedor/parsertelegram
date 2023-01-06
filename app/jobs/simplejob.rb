class SimpleJob
  @queue = :maxcount
  def self.perform(mass)
    myurl="http://127.0.0.1:5300/group/#{mass[0]}/"
    p myurl
    data=dataparshttp(myurl).body
    puts  data

    parsed = JSON.parse(data)
    puts parsed.inspect
    @mygroup=Mygroup.find_by_username("@"+mass[0]).dopmygroup
    if ((parsed["work1"]).to_i>0) && ((parsed["work1"].to_i)<10)   # значение в рабочем диапазоне, все хорошо
       @mygroup.update('tme'=>parsed['data'].to_i,'countuser'=>parsed['count'].to_i)
       p "лог последнее сообщение#{parsed['data']} пользоватлей в группе #{parsed['count']}"
      #в этой ситуации все хорошо, обновляем колличество пользователей и последнее сообщение
    elsif parsed["work1"].to_i==10
      if parsed['count'].to_i>0
      @mygroup.update('tme'=>-1,'countuser'=>parsed['count'].to_i)
      p "лог последнее сообщение не найдено пользоватлей в группе #{parsed['count']}"
      else
        p "лог последнее сообщение не найдено пользоватлей в группе нет"
      end

      #не нашли последнее сообщение на больше меньше
    else # необходимо записать данные об ошибке
      if parsed['flag'].to_i==-1
        @mygroup.update('tme'=>-1,'comment'=>"группа переведена в контакт",'countuser'=>0,'rang'=>-1)
        p "сработала else канал переведен в контакт, пользователей нет"
      elsif parsed['flag'].to_i==-2
        @mygroup.update('tme'=>-1,'comment'=>"скорее всего группы нет",'countuser'=>0,'rang'=>-2)
        p "сработала else канала скорее всего нет"
      end
      # @mygroup.update('countuser'=>parsed['count'].to_i)
      # p "сработала else"  # необходимо добавить признак в доп поле что все завершилось ошибкой
    end
    puts "Job is ok! #{mass[0]}   #{data}   #{parsed.inspect}"
  end

  def self.dataparshttp myurl
    uri = URI.parse(myurl)
    http = Net::HTTP.new(uri.host, uri.port)
    #http.use_ssl = true
    #http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    response
    #Nokogiri::HTML(content)
  end

end