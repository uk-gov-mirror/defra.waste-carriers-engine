class KeyPerson
  include Mongoid::Document

  embedded_in :registration
end
