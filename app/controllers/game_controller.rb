class GameController < ApplicationController
  def play
    @message = "Think of an animal. When you're ready, click the button and I'll try to guess it."
  end

  def start
    if Animal.count == 0
      redirect_to "/game/new_animal"
    else
      redirect_to "/game/guess"
    end
  end

  def new_animal
    @message = "I don't have any animals! Please give me one so we can get started."
  end

  def create_animal
    new_animal = Animal.new
    new_animal.name = params[:animal_field]
    new_animal.save
    if Animal.count == 1
      redirect_to '/'
    else
      session[:new_animal_id] = new_animal.id
      redirect_to '/game/new_question'
    end
  end

  def guess
    @guess = Animal.first.name
    session[:guess_animal_id] = Animal.first.id
  end

  def win
    @message = "Yay, I win! Thanks for playing. Click the button to play again."
    render '/game/play'
  end

  def lose
    @message = "What animal were you thinking of?"
    render '/game/new_animal'
  end

  def create_question
    new_question = Question.new
    new_question.text = params[:question_field]
    new_question.save
    save_answers(new_question, Animal.find(session[:new_animal_id]), Animal.find(session[:guess_animal_id]))
    @message = "Thank you! Click the button to play again."
    render '/game/play'
  end

  def save_answers(new_question, true_animal, false_animal)
    first_answer = Answer.new
    first_answer.animal = true_animal
    first_answer.question = new_question
    first_answer.value = true
    first_answer.save
    second_answer = Answer.new
    second_answer.animal = false_animal
    second_answer.question = new_question
    second_answer.value = false
    second_answer.save
  end
end
