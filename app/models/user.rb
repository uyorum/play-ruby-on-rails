class User < ApplicationRecord
  validates :name, format: /\A[a-zA-Z0-9 ]+\z/
end
