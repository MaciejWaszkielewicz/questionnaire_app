class AnswersController < ApplicationController
  before_action :set_survey
  before_action :set_approach
  before_action :set_answer

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    respond_to do |format|
      if @answer.update answer_params
        format.js
      else
        format.js { render :edit }
      end
    end
  end

  private

  def set_survey
    @survey = Survey.find(params[:survey_id])
  end

  def set_approach
    @approach = @survey.approaches.find(params[:approach_id])
  end

  def set_answer
    @answer = @approach.answers.find(params[:id])
  end

  def answer_params
    params.require(@answer.type.underscore.to_sym).permit(:value)
  end
end
