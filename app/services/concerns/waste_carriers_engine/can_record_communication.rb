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
        recipient: @registration.contact_email
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

    def create_communication_record
      @registration.communication_records.create(communication_record_attributes)
    end
  end
end
