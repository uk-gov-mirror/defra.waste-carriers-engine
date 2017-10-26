json.extract! registration, :id, :reg_identifier, :company_name, :created_at, :updated_at
json.url registration_url(registration, format: :json)
