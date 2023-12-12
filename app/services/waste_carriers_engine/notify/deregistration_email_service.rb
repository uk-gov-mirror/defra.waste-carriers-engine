# frozen_string_literal: true

module WasteCarriersEngine
  module Notify
    class DeregistrationEmailService < BaseSendEmailService
      TEMPLATE_ID = "b9926a88-95db-47bd-96d4-0aaae7a322d3".freeze
      COMMS_LABEL = "Lower tier self serve deregistration invite version 2".freeze

      private

      def notify_options
        {
          email_address: @registration.contact_email,
          template_id: TEMPLATE_ID,
          personalisation: {
            reg_identifier: @registration.reg_identifier,
            company_name: @registration.company_name,
            first_name: @registration.first_name,
            last_name: @registration.last_name,
            deregistration_link: DeregistrationMagicLinkService.run(registration: @registration)
          }
        }
      end
    end
  end
end
