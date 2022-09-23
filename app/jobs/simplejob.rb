class SimpleJob
  @queue = :maxcount
  def self.perform(mass)
    myurl="http://127.0.0.1:5200/group/#{mass[0]}/"
    p myurl
    data=dataparshttp(myurl).body
    puts  data

    parsed = JSON.parse(data)
    puts parsed.inspect
    if ((parsed["work1"]).to_i>0) && ((parsed["work1"].to_i)<10)   # значение в рабочем диапазоне, все хорошо
      p Mygroup.find_by_username("@"+mass[0]).dopmygroup.update('tme'=>parsed['data'].to_i)
    else # необходимо записать данные об ошибке
      p Mygroup.find_by_username("@"+mass[0]).dopmygroup.update('comment'=>"в группе сообщения не найдены")
      #p "сработала else"  # необходимо добавить признак в доп поле что все завершилось ошибкой
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