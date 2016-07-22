class Answer < ActiveRecord::Base
  belongs_to :animal
  belongs_to :question
  validates :animal_id, presence: true
  validates :question_id, presence: true
end
