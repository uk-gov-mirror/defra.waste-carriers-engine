# frozen_string_literal: true

module WasteCarriersEngine
  module CanRecordCommunication
    private

    def communication_record_attributes
      {
        notify_template_id: template_id,
        notification_type: notification_type,
        comms_label: comms_label,
        sent_at: Time.now.utc,
        sent_to: recipient
      }
    end

    def template_id
      raise NotImplementedError, "You must implement template_id for CanRecordCommunication"
    end

    def comms_label
      raise NotImplementedError, "You must implement comms_label for CanRecordCommunication"
    end

    def notification_type
      raise NotImplementedError, "You must implement notification_type for CanRecordCommunication"
    end

    def recipient
      case notification_type
      when "letter"
        [recipient_name, displayable_address(@registration.contact_address)].flatten.join(", ")
      when "sms"
        @registration.phone_number
      else
        @registration.contact_email
      end
    end

    def recipient_address
      @registration.contact_name
    end

    def recipient_name
      [@registration.first_name, @registration.last_name].join(" ")
    end

    def create_communication_record
      @registration.communication_records.create(communication_record_attributes)
    end
  end
end
