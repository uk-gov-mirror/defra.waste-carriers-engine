# frozen_string_literal: true

module WasteCarriersEngine
  module Notify
    class RegistrationPendingConvictionCheckEmailService < BaseSendEmailService
      TEMPLATE_ID = "e7dbb0d2-feca-4f59-a5e6-576e5051f4e0"
      COMMS_LABEL = "Upper tier pending checks"

      private

      def notify_options
        {
          email_address: @registration.contact_email,
          template_id: TEMPLATE_ID,
          personalisation: {
            reg_identifier: @registration.reg_identifier,
            first_name: @registration.first_name,
            last_name: @registration.last_name
          }
        }
      end
    end
  end
end
