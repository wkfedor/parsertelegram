class Wfile < ApplicationRecord
  def self.search(params)
    products = all # for not existing params args
    products = products.where("word like ?", "%#{params[:search]}%") if params[:search]
    products
  end

  def self.todo
     Wfile.where("flag in ('1', '429')").count
  end

  def self.invork
     Wfile.where("flag in ('200', '201')").count
  end

  def self.error
    Wfile.where("flag in ('400', '401')").count
  end




end
