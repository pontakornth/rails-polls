class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show edit update destroy vote result]
  before_action :authenticate_user!, only: %i[vote]

  # GET /questions or /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1 or /questions/1.json
  def show
    redirect_to result_path(@question) unless @question.can_vote
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit; end

  # GET /questions/1/result
  def result; end

  # POST /questions/1/vote
  def vote
    redirect_to result_path(@question) unless @question.can_vote
    choice_id = choice_param[:choice_id]
    choice = @question.choices.find(choice_id)
    previous_vote = Vote.where(question: @question).find_by(user: current_user)
    # If there is no previous vote, create one.
    if !previous_vote
      choice.votes.create(user: current_user, question: @question)
    # If it is a different choice, change
    elsif previous_vote.choice != choice
      previous_vote.choice = choice
      previous_vote.save
    end
    # Do nothing if it is the same choice
    redirect_to result_path(params[:id])
  end

  # POST /questions or /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to question_url(@question), notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1 or /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to question_url(@question), notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1 or /questions/1.json
  def destroy
    @question.destroy

    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_question
    @question = Question.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def question_params
    params.require(:question).permit(:question_text, :description)
  end

  def choice_param
    params.permit(:choice_id)
  end
end
