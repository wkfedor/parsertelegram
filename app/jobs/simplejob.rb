class SimpleJob
  @queue = :maxcount
  def self.perform(mass)
    myurl="http://127.0.0.1:5200/group/#{mass[0]}/"
    p myurl
    data=dataparshttp(myurl).body
    puts  data

    parsed = JSON.parse(data)
    puts parsed.inspect
    @mygroup=Mygroup.find_by_username("@"+mass[0]).dopmygroup
    if ((parsed["work1"]).to_i>0) && ((parsed["work1"].to_i)<10)   # значение в рабочем диапазоне, все хорошо
      p @mygroup.update('tme'=>parsed['data'].to_i)

      if parsed['count']!=0
        p @mygroup.update('countuser'=>parsed['count'].to_i)
      end


    else # необходимо записать данные об ошибке
      p @mygroup.update('countuser'=>parsed['count'].to_i)
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