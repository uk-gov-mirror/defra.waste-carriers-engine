class KeyPerson
  include Mongoid::Document

  embedded_in :registration
  embeds_one :convictionSearchResult

  accepts_nested_attributes_for :convictionSearchResult

  # TODO: Confirm types
  field :first_name,  type: String
  field :last_name,   type: String
  field :position,    type: String
  # Do we need all these date fields? TODO: Compare against existing DB
  field :dob_day,     type: Integer
  field :dob_month,   type: Integer
  field :dob_year,    type: Integer
  field :dob,         type: DateTime
  field :person_type, type: String # "Key" by default, but why would you add an irrelevant person?

  validates :first_name, :last_name, :position, :dob, :person_type,
            presence: true
end
