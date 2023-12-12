# frozen_string_literal: true

module WasteCarriersEngine
  module Notify
    class BaseSendEmailService < BaseService
      include WasteCarriersEngine::ApplicationHelper
      include ActionView::Helpers::NumberHelper

      NOTIFICATION_TYPE = "email".freeze

      def run(registration:, order: nil, requester: nil)
        # AD registrations will not have a contact_mail
        return unless registration&.contact_email.present?

        @registration = registration
        @order = order
        @requester = requester

        client = Notifications::Client.new(WasteCarriersEngine.configuration.notify_api_key)
        client.send_email(notify_options)
        create_communication_record
      end

      private

      def registration_type
        return unless @registration.upper_tier?

        I18n.t(
          "waste_carriers_engine.registration_type.upper.#{@registration.registration_type}"
        )
      end

      def communication_record_attributes
        {
          notify_template_id: template_id,
          notification_type: NOTIFICATION_TYPE,
          comms_label: COMMS_LABEL,
          sent_at: Time.now.utc
        }
      end

      def create_communication_record
        @registration.communication_records.create(communication_record_attributes)
      end

      def template_id
        TEMPLATE_ID
      end
    end
  end
end
