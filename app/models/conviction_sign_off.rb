class ConvictionSignOff
  include Mongoid::Document

  embedded_in :registration
end
