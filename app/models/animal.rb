class Animal < ActiveRecord::Base
  has_many :answers
  validates :name, presence: true
  validates :name, uniqueness: true
end
