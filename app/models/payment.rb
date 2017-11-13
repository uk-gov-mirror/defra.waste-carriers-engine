class Payment
  include Mongoid::Document

  embedded_in :financeDetails

  # TODO: Confirm types
  # TODO: Confirm if all of these are needed
  field :orderKey,                type: Integer
  field :amount,                  type: Integer
  field :currency,                type: String
  field :mac_code,                type: String
  field :dateReceived,            type: DateTime
  field :dateEntered,             type: DateTime
  field :dateReceived_year,       type: Integer # Not sure if this is required
  field :dateReceived_month,      type: Integer # Not sure if this is required
  field :dateReceived_day,        type: Integer # Not sure if this is required
  field :registrationReference,   type: String
  field :worldPayPaymentStatus,   type: String
  field :updatedByUser,           type: String
  field :comment,                 type: String
  field :paymentType,             type: String
  field :manualPayment,           type: String
end
