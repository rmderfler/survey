require 'active_record'
require './lib/question'
require './lib/response'
require './lib/survey'
require './lib/answer'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def menu
  puts "Welcome to the jungle"
  choice = nil
  until choice == 'e'
    puts "Press 's' to create a new survey"
    puts "Press 't' to take a survey"
    puts "Press 'l' to list all answers by question"
    choice = gets.chomp
    case choice
    when 's'
      new_survey
    when 't'
      choose_survey
    when 'l'
      list_answers
    else
      puts "not a valid option"
    end
  end
end

def new_survey
  puts "What is the name of the survey?"
  survey = Survey.create({:name => gets.chomp})
  add_question(survey.id)
end

def add_question(input_survey_id)
  puts "What is the question you would like to add?"
  question = Question.create({:description => gets.chomp, :survey_id => input_survey_id})
  add_response(question.id, input_survey_id)
end

def add_response(input_question_id, input_survey_id)
  puts "What is the response you would like to add?"
  response = Response.create({:description => gets.chomp, :question_id => input_question_id})
  puts "Do you want to add another possible response?"
  input = gets.chomp
  if input == 'y'
    add_response(input_question_id, input_survey_id)
  elsif input == 'n'
    puts "Would you like to add another question?"
    input =gets.chomp
    if input == 'y'
      add_question(input_survey_id)
    elsif input == 'n'
      menu
    end
  end
end

def choose_survey
  Survey.all.each { |survey| puts survey.name }
  puts "Which survey would you like to take?"
  survey = Survey.find_by(:name => gets.chomp)
  take_survey(survey.id)
end

def take_survey(survey_id)
  survey = Survey.find(survey_id)
  survey.questions.all.each do |question|
    puts question.description
    Response.all.each do |response|
      if response.question_id ==question.id
        puts response.description
      end
    end
    answer = Answer.create({:choice => gets.chomp, :question_id => question.id})
  end
  menu
end

def list_answers
  Question.all.each { |question| puts question.description }
  question = Question.find_by(:description => gets.chomp)
  question.answers.all.each { |answer| puts answer.choice }
  menu
end
menu
