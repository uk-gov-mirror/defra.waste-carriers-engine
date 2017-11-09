class FinanceDetails
  include Mongoid::Document

  embedded_in :registration

  # TODO: Add additional embedded stuff!
  # embeds_many orders
  # embeds_many payments

  # TODO: Confirm types
  field :balance, Type: BigDecimal
end
