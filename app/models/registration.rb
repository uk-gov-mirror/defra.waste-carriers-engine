class Registration
  include CanChangeStatus
  include Mongoid::Document

  # Fields
  field :regIdentifier, type: String
  field :companyName, type: String
  field :status, type: String
  field :expiresOn, type: DateTime

  # Validations
  validates :regIdentifier, :status,
            presence: true
end
