class AssistantsController < ApplicationController
  include DemoCollections
  before_action :set_assistant, only: %i[show edit update destroy]
  before_action :all_departments, only: %i[new edit create update]
  before_action :all_roles, only: %i[new edit create update]
  before_action :all_offices, only: %i[new edit create update]
  before_action :set_fillings, only: %i[new edit create update]
  before_action :set_colours, only: %i[new edit create update]

  # GET /assistants
  def index
    @assistants = Assistant.all
  end

  # GET /assistants/1
  def show; end

  # GET /assistants/new
  def new
    @assistant = Assistant.new
    @assistants = Assistant.all
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

  def all_departments
    @departments = Department.all
  end

  def all_roles
    @roles = Role.all
  end

  def all_offices
    @offices = Office.all
  end

  def set_fillings
    @fillings = fillings
  end

  def set_colours
    @colours = colours
  end

  # Only allow a list of trusted parameters through.
  def assistant_params
    params.require(:assistant).permit(:title, :date_of_birth, :description, :cv, :terms_agreed, :lunch_option, :department_id, :role_id, :office_id, :desired_filling)
  end
end
