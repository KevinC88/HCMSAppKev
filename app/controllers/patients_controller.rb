require 'my_logger'

class PatientsController < ApplicationController

before_filter :authenticate_user!
 before_filter :ensure_admin, :only => [:edit, :destroy]

  before_action :set_patient, only: [:show, :edit, :update, :destroy]

def ensure_admin
unless current_user && current_user.admin?
render :text => "Access Error Message", :status => :unauthorized
 end
end

  # GET /patients
  # GET /patients.json
  def index
    @patients = Patient.all

if params[:search]
@patients = Patient.search(params[:search])
@patients = @patients.order("created_at ASC")
else
@patients = @patients.order("created_at DESC")
end

  end

  # GET /patients/1
  # GET /patients/1.json
  def show
  end

  # GET /patients/new
  def new
    @patient = Patient.new
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients
  # POST /patients.json
  def create
    @patient = Patient.new(patient_params)
logger = MyLogger.send :new
logger.logInformation("A new patient has been added: "+@patient.firstname+","+@patient.lastname+" at "+Time.now.to_s)

    respond_to do |format|
      if @patient.save
        format.html { redirect_to @patient, notice: 'Patient was successfully created.' }
        format.json { render :show, status: :created, location: @patient }
      else
        format.html { render :new }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to @patient, notice: 'Patient was successfully updated.' }
        format.json { render :show, status: :ok, location: @patient }
      else
        format.html { render :edit }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    @patient.destroy
    respond_to do |format|
      format.html { redirect_to patients_url, notice: 'Patient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_params
      params.require(:patient).permit(:firstname, :lastname, :dob, :complaint, :address)
    end


end
