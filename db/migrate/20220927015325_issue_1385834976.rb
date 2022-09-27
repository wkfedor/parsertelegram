class Issue1385834976 < ActiveRecord::Migration[7.0]
  def change # создал миграцию просто с именнем ишью
    add_column :dopmygroups, :endnow, :integer, comment: "номер сообщения на котором остановились на сайте t.me"
    add_column :dopmygroups, :rang, :integer, comment: "ранг группы по приросту сообщений"
    add_column :dopmygroups, :myrang, :integer, comment: "ранг группы по значимости субъективно, ставлю в ручную"
    add_column :dopmygroups, :datenow, :datetime, comment: "дата сообщения на котором остановислись"
    add_column :dopmygroups, :datetodo, :datetime, comment: "дата найденного сообщения в конце"
    add_column :dopmygroups, :todo, :integer, comment: "колличество сообщений между datenow и datetodo"
  end
end
