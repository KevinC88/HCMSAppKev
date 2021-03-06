require 'my_logger'

class RequestsController < ApplicationController

before_filter :authenticate_user!
 before_filter :ensure_admin, :only => [:edit, :destroy]

  def index
@patient = Patient.find(params[:patient_id])
@requests = @patient.requests
  end

  def show
@patient = Patient.find(params[:patient_id])
@request = @patient.requests.find(params[:id])
  end

  def new
@patient = Patient.find(params[:patient_id])
@request = @patient.requests.build
  end

def create
@patient = Patient.find(params[:patient_id])
@request = @patient.requests.build(params.require(:request).permit(:procedure, :specialist, :status, :date))
logger = MyLogger.send :new
      logger.logInformation("A new request has been added - "+@patient.firstname+","+@patient.lastname+","+@request.procedure+","+@request.specialist+","+@request.status+" at "+Time.now.to_s)

if @request.save
redirect_to patient_request_url(@patient, @request)
else
render :action => "new"
end
end


  def edit
@patient = Patient.find(params[:patient_id])
@request = @patient.requests.find(params[:id])
  end

def update
@patient = Patient.find(params[:patient_id])
@request = Request.find(params[:id])
if @request.update_attributes(params.require(:request).permit(:procedure, :specialist, :status, :date))
redirect_to patient_request_url(@patient, @request)
else
render :action => "edit"
end
end

def destroy
@patient = Patient.find(params[:patient_id])
@request = Request.find(params[:id])
@request.destroy
respond_to do |format|
format.html { redirect_to patient_requests_path(@patient) }
format.xml { head :ok }
end
end

end
