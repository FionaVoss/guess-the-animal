require 'rails_helper'
require 'testing_methods'

RSpec.feature "Games", type: :feature do
  context "playing the game" do
    Steps "playing the game with no animals in the database" do
      Given "I am on the landing page" do
        visit "/"
        expect(page).to have_content "Think of an animal. When you're ready, click the button and I'll try to guess it."
      end
      Then "I can start the game by clicking a button" do
        click_link "I'm ready!"
      end
      And "I am asked to submit an animal" do
        expect(page).to have_content "I don't have any animals! Please give me one so we can get started"
        fill_in 'animal_field', with: "tiger"
        click_button 'Submit'
      end
      And "the animal is added to the database" do
        expect(Animal.first.name).to eq 'tiger'
      end
      And 'I am redirected to the landing page' do
        expect(page).to have_content 'Guess the animal'
      end
    end
    Steps "losing the game with one animal in the database" do
      Given "there is one animal in the database" do
        create_animal("tiger")
      end
      And 'I have started the game' do
        visit "/"
        click_link "I'm ready!"
      end
      Then "I am asked if that's my animal" do
        expect(page).to have_content "Is it a tiger?"
      end
      And "if I click 'yes'" do
        click_link 'Yes, you win!'
      end
      Then "I am asked to play again" do
        expect(page).to have_content "Yay, I win! Thanks for playing. Click the button to play again."
      end
    end
    Steps "winning the game with one animal in the database" do
      Given "there is one animal in the database" do
        create_animal("tiger")
      end
      And 'I have started the game' do
        visit "/"
        click_link "I'm ready!"
      end
      Then "I am asked if that's my animal" do
        expect(page).to have_content "Is it a tiger?"
      end
      And "if I click 'no'" do
        click_link 'No, you lose!'
      end
      Then "I can submit my animal" do
        expect(page).to have_content "What animal were you thinking of?"
        fill_in 'animal_field', with: "chinchilla"
        click_button 'Submit'
      end
      And "the animal is added to the database" do
        expect(Animal.last.name).to eq 'chinchilla'
      end
      And "I can submit a question" do
        expect(page).to have_content 'Please submit a question to help me get smarter. The answer should be "Yes" for a chinchilla and "No" for a tiger.'
        fill_in 'question_field', with: 'Does it eat hay?'
        click_button 'Submit'
      end
      And "my question gets saved in the database" do
        expect(Question.first.text).to eq 'Does it eat hay?'
      end
      And 'the answers get saved in the database' do
        expect(Answer.count).to eq 2
        expect(Animal.find_by_name('chinchilla').answers.count).to eq 1
        expect(Animal.find_by_name('chinchilla').answers.first.question.text).to eq 'Does it eat hay?'
        expect(Animal.find_by_name('chinchilla').answers.first.value).to eq true
        expect(Animal.find_by_name('tiger').answers.count).to eq 1
        expect(Animal.find_by_name('tiger').answers.first.question.text).to eq 'Does it eat hay?'
        expect(Animal.find_by_name('tiger').answers.first.value).to eq false
      And "I am asked to play again" do
        expect(page).to have_content "Thank you! Click the button to play again."
      end
    end
  end
end
