class QuestionsController < ApplicationController 


  def index
    questions = Question.all
    render json: questions
  end

  def update

  end

end