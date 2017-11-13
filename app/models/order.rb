class Order
  include Mongoid::Document

  embedded_in :financeDetails
  embeds_many :orderItems

  accepts_nested_attributes_for :orderItems

  # TODO: Confirm types
  # TODO: Confirm if all of these are actually required
  field :orderId,               type: String
  field :orderCode,             type: Integer
  field :paymentMethod,         type: String
  field :merchantId,            type: String
  field :totalAmount,           type: Integer # TODO: Confirm
  field :currency,              type: String
  field :dateCreated,           type: DateTime
  field :worldPayStatus,        type: String
  field :dateLastUpdated,       type: DateTime
  field :updatedByUser,         type: String
  field :description,           type: String
  field :amountType,            type: String
  field :exception,             type: String
  field :manualOrder,           type: String
  field :order_item_reference,  type: String
end
