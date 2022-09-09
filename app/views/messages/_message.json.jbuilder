json.extract! message, :id, :maintext, :user, :img, :dopid, :mygroup_id, :created_at, :updated_at
json.url message_url(message, format: :json)
