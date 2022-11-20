class Message < ApplicationRecord
  belongs_to :mygroup

  scope :indata, ->(a,b) { where("mygroup_id = (?) and dopid = (?)", a,b) }
end
