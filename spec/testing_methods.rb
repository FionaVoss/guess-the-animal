def create_animal(new_name)
  new_animal = Animal.new
  new_animal.name = new_name
  new_animal.save
end

def create_question(question)
  new_question = Question.new
  new_question.text = question
  new_question.save
end

def create_answer(question_text, animal_name, new_value)
  answer = Answer.new
  answer.animal = Animal.find_by_name(animal_name)
  answer.question = Question.find_by_text(question_text)
  answer.value = new_value
  answer.save
end
