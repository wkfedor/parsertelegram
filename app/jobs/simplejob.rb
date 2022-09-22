class SimpleJob
  #require 'open-uri'
  #require 'nokogiri'
  #require "net/https"
  #require 'uri'
  @queue = :maxcount
  def self.perform(mass)
    # здесь делаем важные и полезные вещи
    #testq = Testq.find(mass[0])
    #p "---#{testq.inspect}---"
    #testq.commentq="#{testq.commentq}, #{mass[1]}"
    #testq.save
    sleep(5)
    #Mywork.findgroupfilter(x)
    myurl="http://127.0.0.1:5200/group/#{mass[0]}/"
    p myurl
    data=dataparshttp(myurl).body
    puts "Job is ok! #{mass[0]}   #{data}"
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