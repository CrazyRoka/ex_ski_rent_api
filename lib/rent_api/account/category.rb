class Category < ApplicationRecord
  has_and_belongs_to_many :pins

  validates :name, presence: true
end
