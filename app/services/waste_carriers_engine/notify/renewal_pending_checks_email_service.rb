# frozen_string_literal: true

module WasteCarriersEngine
  module Notify
    class RenewalPendingChecksEmailService < BaseSendEmailService
      TEMPLATE_ID = "d2442022-4f4c-4edd-afc5-aaa0607dabdf".freeze
      COMMS_LABEL = "Upper tier renewal pending checks".freeze
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
