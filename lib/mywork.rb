class Mywork < ApplicationController
  require 'open-uri'
  require 'nokogiri'
  require "net/https"
  require 'uri'
  def self.myreq data
     data.scan(/@[a-z1-9]*/).uniq - ["@","@id"]
  end

  def self.findgroupfilter word # проверяем есть ли группа в базе первого фильтра
    Wfile.find_by_word(word) ? false : true
  end

  def self.findgroup word # проверяем есть ли группа в основной базе
    Mygroup.find_by_username(word) ? false : true
  end

  def self.mygropdata word # отправляю имя группы полуаю данные о ней
    p myurl = "https://t.me/#{word.delete "@" }"
     uri = URI.parse(myurl)
     http = Net::HTTP.new(uri.host, uri.port)
     http.use_ssl = true
     http.verify_mode = OpenSSL::SSL::VERIFY_NONE
     request = Net::HTTP::Get.new(uri.request_uri)
     response = http.request(request)
     content=response.body
     #"code=#{response.code}"
      @t={}
     if response.code == '200'
        doc = Nokogiri::HTML(content)
        p  doc.xpath(".//*[@class='tgme_page_description']//text()").first
     end
=begin
    myurl = "https://api.telegram.org/#{ENV['TOKEN']}/getChat?chat_id=#{word}"
    p "myurl=#{myurl}"
    uri = URI.parse(myurl)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    content=response.body
    @msql=Wfile.find_by_word(word)
    p "code=#{response.code}"
    if response.code == '200'
=end


  end


end