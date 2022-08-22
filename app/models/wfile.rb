class Wfile < ApplicationRecord
  mount_uploader :myfile, MyfileUploader
end
