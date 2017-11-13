class ConvictionSignOff
  include Mongoid::Document

  embedded_in :registration

  # TODO: Confirm types
  field :confirmed, type: Boolean
  field :confirmedAt, type: DateTime
  field :confirmedBy, type: String
end
