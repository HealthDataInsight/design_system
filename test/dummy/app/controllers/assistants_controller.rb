class AssistantsController < ApplicationController
  before_action :set_assistant, only: %i[show edit update destroy]

  # GET /assistants
  def index
    @assistants = Assistant.all
  end

  # GET /assistants/1
  def show; end

  # GET /assistants/new
  def new
    @assistant = Assistant.new
  end

  # GET /assistants/1/edit
  def edit; end

  # POST /assistants
  def create
    @assistant = Assistant.new(assistant_params)

    if @assistant.save
      redirect_to @assistant, notice: t('notices.create.success', model: @assistant.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /assistants/1
  def update
    if @assistant.update(assistant_params)
      redirect_to @assistant, notice: t('notices.update.success', model: @assistant.model_name.human), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /assistants/1
  def destroy
    @assistant.destroy!
    redirect_to assistants_url, notice: t('notices.destroy.success', model: @assistant.model_name.human), status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_assistant
    @assistant = Assistant.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def assistant_params
    params.require(:assistant).permit(
      :age,
      :cv,
      :date_of_birth,
      :department_id,
      :description,
      :email,
      :password,
      :phone,
      :role_id,
      :title,
      :website
      # :colour,
      # :desired_filling,
      # :lunch_option,
      # :terms_agreed,
    )
  end
end
