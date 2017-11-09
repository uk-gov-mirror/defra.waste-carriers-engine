class Payment
  include Mongoid::Document

  embedded_in :financeDetails

  # TODO: Confirm types
  # TODO: Confirm if all of these are needed
  field :orderKey
  field :amount
  field :currency
  field :mac_code
  field :dateReceived
  field :dateEntered
  field :dateReceived_year
  field :dateReceived_month
  field :dateReceived_day
  field :registrationReference
  field :worldPayPaymentStatus
  field :updatedByUser
  field :comment
  field :paymentType
  field :manualPayment
end
