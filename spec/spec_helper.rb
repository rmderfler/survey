require 'active_record'
require 'rspec'
require 'question'
require 'survey'
require 'response'
require 'answer'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["test"])

RSpec.configure do |config|
  config.after(:each) do
    Question.all.each { |question| question.destroy }
    Survey.all.each { |survey| survey.destroy }
    Response.all.each { |response| response.destroy }
    Answer.all.each { |answer| answer.destroy }
  end
end
