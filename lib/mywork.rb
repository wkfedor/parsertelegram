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
      t={}
     if response.code == '200'
        doc = Nokogiri::HTML(content)
        t['url'] = myurl
        t['description'] = doc.xpath(".//*[@class='tgme_page_description']//text()").text  #описание
        t['extra'] = doc.xpath(".//*[@class='tgme_page_extra']//text()").text         #чел
        t['title'] = doc.xpath(".//*[@class='tgme_page_title']//text()").text        #title
        t['error']=response.code
        p t.inspect
        return t
     else
       p "error"
       p response.code
       t['error']=response.code
       p t.inspect
       return t

     end
  end

  def self.delspec text
    pattern = /!|’|"|\\/
    text.delete!('\n')
    text.delete!("\n")
    text = text.gsub(pattern,"")
    text.strip!
  end

end
