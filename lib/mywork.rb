class Mywork < ApplicationController
  def self.myreq data
     data.scan(/@[a-z1-9]*/).uniq - ["@","@id"]
  end
end