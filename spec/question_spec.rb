require 'spec_helper'

describe 'Question' do
  it 'belongs to a survey' do
    survey = Survey.create({:name => 'clipboard'})
    question = Question.create(:survey_id => survey.id)
    expect(question.survey_id).to eq survey.id
  end
end
