ActiveRecord::Base.establish_connection("sqlite3:db/development.db")

class Gif < ActiveRecord::Base
  has_secure_password
end
