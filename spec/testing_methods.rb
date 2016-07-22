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

def create_answers(question_text, true_animal_name, false_animal_name)
  first_answer = Answer.new
  first_answer.animal = Animal.find_by_name(true_animal_name)
  first_answer.question = Question.find_by_text(question_text)
  first_answer.value = true
  first_answer.save
  second_answer = Answer.new
  second_answer.animal = Animal.find_by_name(false_animal_name)
  second_answer.question = Question.find_by_text(question_text)
  second_answer.value = false
  second_answer.save
end
