class RegistrationsController < ApplicationController
  before_action :set_registration, only: %i[show edit update destroy]
  before_action :authenticate_user!

  # GET /registrations
  # GET /registrations.json
  def index
    # Only loading 50 for now
    @registrations = Registration.all.limit(50)
  end

  # GET /registrations/1
  # GET /registrations/1.json
  def show; end

  # GET /registrations/new
  def new
    @registration = Registration.new
  end

  # GET /registrations/1/edit
  def edit; end

  # POST /registrations
  # POST /registrations.json
  def create
    @registration = Registration.new(registration_params)
    @registration.metaData = MetaData.new

    respond_to do |format|
      if @registration.save
        format.html { redirect_to @registration, notice: "Registration was successfully created." }
        format.json { render :show, status: :created, location: @registration }
      else
        format.html { render :new }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /registrations/1
  # PATCH/PUT /registrations/1.json
  def update
    respond_to do |format|
      if @registration.update(registration_params)
        format.html { redirect_to @registration, notice: "Registration was successfully updated." }
        format.json { render :show, status: :ok, location: @registration }
      else
        format.html { render :edit }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registrations/1
  # DELETE /registrations/1.json
  def destroy
    @registration.destroy
    respond_to do |format|
      format.html { redirect_to registrations_url, notice: "Registration was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_registration
    @registration = Registration.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def registration_params
    params.require(:registration).permit(:regIdentifier,
                                         :companyName)
  end
end
