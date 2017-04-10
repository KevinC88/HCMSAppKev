json.extract! patient, :id, :firstname, :lastname, :dob, :complaint, :address, :created_at, :updated_at
json.url patient_url(patient, format: :json)
