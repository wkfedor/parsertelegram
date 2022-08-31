class Mywork < ApplicationController
  def self.myreq data
     data.scan(/@[a-z1-9]*/).uniq - ["@","@id"]
  end

  def self.findgroupfilter word # проверяем есть ли группа в базе первого фильтра
    Wfile.find_by_word(word) ? false : true
  end

  def self.findgroup word # проверяем есть ли группа в основной базе
    Mygroup.find_by_username(word) ? false : true
  end

end