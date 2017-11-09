class ConvictionSearchResult
  include Mongoid::Document

  embedded_in :registration, :keyPerson

  # TODO: Confirm types
  field :match_result, type: String
  field :matching_system, type: String
  field :reference, type: String
  field :matched_name, type: String
  field :searched_at, type: DateTime
  field :confirmed, type: Boolean
  field :confirmed_at, type: DateTime
  field :confirmed_by, type: String
end
