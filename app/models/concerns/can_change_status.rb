module CanChangeStatus
  extend ActiveSupport::Concern

  included do
    include AASM

    aasm column: :status do
      # States
      state :pending, initial: true
      state :active
      state :revoked
      state :refused
      state :expired

      # Transitions
      after_all_transitions :log_status_change

      # TODO: Confirm what this workflow actually is
      event :activate do
        transitions from: :pending,
                    to: :active
      end

      event :revoke do
        transitions from: :active,
                    to: :revoked
      end

      event :refuse do
        transitions from: :pending,
                    to: :refused
      end

      event :expire do
        transitions from: :active,
                    to: :expired
      end

      event :renew do
        transitions from: %i[active
                             expired],
                    to: :active,
                    after: :update_registration_dates
      end
    end

    def log_status_change
      logger.debug "Changing from #{aasm.from_state} to #{aasm.to_state} (event: #{aasm.current_event})"
    end

    def update_registration_dates
      logger.debug "3 more years!"
      # TODO: Update the dates
      # Maybe move this method out of here - should probably be a separate module
    end
  end
end
