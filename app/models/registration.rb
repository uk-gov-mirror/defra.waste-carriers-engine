class Registration
  include CanChangeStatus
  include Mongoid::Document

  field :reg_identifier, type: String
  field :company_name, type: String
  field :status, type: String
  field :expires_on, type: DateTime

  validates :reg_identifier, :status,
            presence: true
end
