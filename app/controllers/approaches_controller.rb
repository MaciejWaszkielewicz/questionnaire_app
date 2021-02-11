class ApproachesController < ApplicationController
  before_action :set_survey
  before_action :set_section, only: [:new, :create]

  def index
    @approaches = @survey.approaches
  end

  def show
    @approach = @survey.approaches.find(params[:id])
  end

  def new
    if @section != @survey.sections.first
      return redirect_to new_survey_section_approach_path(@survey, @survey.sections.first)
    end
    if session["survey_#{@survey.id}_approach_new"].present?
      session.delete "survey_#{@survey.id}_approach_new"
    end
    prepare_answers_params
    @approach = @survey.approaches.new({ answers_attributes: @answers_params })
  end

  def create
    unless prepare_answers_params
      return redirect_to new_survey_section_approach_path(@survey, @survey.sections.first), notice: "Questions was changed! You have to start again!"
    end
    unless merge_answers_params
      return redirect_to new_survey_section_approach_path(@survey, @survey.sections.first), notice: "Questions was changed! You have to start again!"
    end
    @approach = @survey.approaches.new({ answers_attributes: @answers_params })

    # assign next section if all answers for current section are valid
    unless @approach.answers.select{ |answer|
        @section.questions.pluck(:id).include?(answer.question_id) and \
        !answer.valid?
      }.any?
      @section = @survey.sections.find(params[:next_section]) if params[:next_section].present?
    end

    unless params[:next_section].present?
      if @approach.save
        session.delete "survey_#{@survey.id}_approach_new"
        return redirect_to survey_approach_path(@survey, @approach)
      end
    end
    render :new
  end

  def destroy
    @approach = @survey.approaches.find(params[:id])
    @approach.destroy
    redirect_to survey_approaches_path(@survey), notice: "Aproach successfuly destroyed!"
  end

  private

  def set_survey
    @survey = Survey.find(params[:survey_id])
  end

  def set_section
    @section = @survey.sections.find(params[:section_id])
  end

  def prepare_answers_params
    @answers_params = session["survey_#{@survey.id}_approach_new"] || @survey.questions.map { |question|
      {
        question_id: question.id,
        type: question.value_type,
        value: nil
      }
    }
    if @answers_params.length != @survey.questions.count
      false
    end
    true
  end

  def merge_answers_params
    if params[:approach].present?
      if approach_params[:answers_attributes].present?
        approach_params[:answers_attributes].values.each do |new_answer|
          answers = @answers_params.select{ |answer| new_answer[:question_id].to_i == answer.symbolize_keys[:question_id].to_i }
          if answers.present?
            answers.each do |answer|
              answer[:value] = new_answer[:value]
            end
          else
            return false
          end
        end
      end
    end
    session["survey_#{@survey.id}_approach_new"] = @answers_params
    true
  end

  def approach_params
    params.require(:approach).permit(
      answers_attributes:
        [
          :question_id,
          :value
        ]
    )
  end
end