class FinanceDetails
  include Mongoid::Document

  embedded_in :registration
  embeds_many :orders
  embeds_many :payments

  accepts_nested_attributes_for :orders, :payments

  # TODO: Confirm types
  field :balance, Type: BigDecimal
end
