class Dopmygroup < ApplicationRecord
  has_one :mygroup

  def self.start(id)
    Dopmygroup.where("mygroup_id=#{id}").first&.countuser
  end

end
