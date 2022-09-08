class Dopmygroup < ApplicationRecord
  has_one :mygroup

  def self.start(id)
    Dopmygroup.where("mygroup_id=#{id}").first&.countuser
  end

  def self.search(params)
    products = all # for not existing params args
    products = products.where("mygroup_id in (select id from mygroups where username like ?)", "%#{params[:search]}%") if params[:search]

    products
  end

end
