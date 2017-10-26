class Registration < ActiveRecord::Base
  include CanChangeStatus

  validates :reg_identifier, :status,
            presence: true
end
