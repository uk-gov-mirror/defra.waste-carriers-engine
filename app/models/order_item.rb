class OrderItem
  include Mongoid::Document

  embedded_in :order

  # TODO: Confirm types
  field :amount
  field :currency
  field :lastUpdated
  field :description
  field :reference
  field :type
end
