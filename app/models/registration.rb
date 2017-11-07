class Registration
  include Mongoid::Document

  embeds_one :metaData
  accepts_nested_attributes_for :metaData

  # Fields
  field :uuid,                    type: String
  field :tier,                    type: String
  field :registrationType,        type: String
  field :businessType,            type: String
  field :otherBusinesses,         type: Boolean
  field :isMainService,           type: Boolean
  field :onlyAMF,                 type: Boolean
  field :companyName,             type: String
  field :companyNo,               type: Integer
  field :firstName,               type: String
  field :lastName,                type: String
  field :phoneNumber,             type: Integer # Are we sure? Could contain + () etc
  field :contactEmail,            type: String
  field :addresses,               type: Array
  field :keyPeople,               type: Array
  field :accountEmail,            type: String
  field :declaredConvictions,     type: Boolean
  field :declaration,             type: Integer # Unsure of type
  field :regIdentifier,           type: String
  field :expiresOn,               type: DateTime
  field :financeDetails,          type: Hash
  field :convictionSearchResult,  type: Hash
  field :conviction_sign_offs,    type: Array # Why is this snake case and the others are camelCase why why why

  # Validations
  validates :regIdentifier,
            presence: true
end
