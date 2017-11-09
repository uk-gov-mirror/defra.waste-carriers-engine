class Order
  include Mongoid::Document

  embedded_in :financeDetails

  embeds_many :orderItems

  # TODO: Confirm types
  # TODO: Confirm if all of these are actually required
  field :orderId
  field :orderCode
  field :paymentMethod
  field :merchantId
  field :totalAmount
  field :currency
  field :dateCreated
  field :worldPayStatus
  field :dateLastUpdated
  field :updatedByUser
  field :description
  field :amountType
  field :exception
  field :manualOrder
  field :order_item_reference
end
