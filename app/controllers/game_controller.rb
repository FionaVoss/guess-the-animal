class GameController < ApplicationController
  def play
    @message = "Think of an animal. When you're ready, click the button and I'll try to guess it."
  end

  def start
    if Animal.count == 0
      redirect_to "/game/new_animal"
    elsif Question.count == 0
      redirect_to "/game/guess"
    else
      redirect_to '/game/ask'
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
      @new_animal = new_animal
      session[:new_animal_id] = @new_animal.id
      @guess_animal = Animal.find(session[:guess_animal_id])
      render '/game/new_question'
    end
  end

  def guess
    @guess = Animal.first.name
    session[:guess_animal_id] = Animal.first.id
    if !session[:possible_animals].nil?
      @possible_animals = YAML.load(session[:possible_animals])
      if @possible_animals.length == 1
        @guess = Animal.find(@possible_animals.first).name
        session[:guess_animal_id] = Animal.find(@possible_animals.first).id
      end
    end
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
    @new_animal_id = session[:new_animal_id]
    @guess_animal = Animal.find(session[:guess_animal_id])
    save_answers(new_question, Animal.find(@new_animal_id), @guess_animal)
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

  def ask
    @question = Question.first
    session[:current_question_id] = @question.id
  end

  def yes
    @question = Question.find(session[:current_question_id])
    @relevant_answers = Answer.where(question: @question, value: true)
    @possible_animals = []
    @relevant_answers.each do |answer|
      if !@possible_animals.include? answer.animal
        @possible_animals << answer.animal.id
      end
    end
    session[:possible_animals] = @possible_animals.to_yaml
    redirect_to '/game/guess'
  end

  def no
  end
end
