class FinanceDetails
  include Mongoid::Document

  embedded_in :registration
end
