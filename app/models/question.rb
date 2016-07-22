class Question < ActiveRecord::Base
  has_many :answers
  validates :text, presence: true
  validates :text, uniqueness: true
end
