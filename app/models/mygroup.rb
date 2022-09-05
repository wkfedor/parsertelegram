class Mygroup < ApplicationRecord
  def self.search(params)
    products = all # for not existing params args
    products = products.where("username like ?", "%#{params[:search]}%") if params[:search]
    products
  end
end
