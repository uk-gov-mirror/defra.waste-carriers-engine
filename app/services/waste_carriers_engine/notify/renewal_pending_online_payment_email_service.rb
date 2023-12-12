# frozen_string_literal: true

module WasteCarriersEngine
  module Notify
    class RenewalPendingOnlinePaymentEmailService < BaseSendEmailService
      TEMPLATE_ID = "3da098e3-3db2-4c99-8e96-ed9d1a8ef227".freeze
      COMMS_LABEL = "Upper tier renewal pending online payment".freeze
      private

      def notify_options
        {
          email_address: @registration.contact_email,
          template_id: TEMPLATE_ID,
          personalisation: {
            reg_identifier: @registration.reg_identifier,
            registration_type: registration_type
          }
        }
      end
    end
  end
end
