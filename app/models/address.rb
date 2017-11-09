class Address
  include Mongoid::Document

  embedded_in :registration
end
