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
                    guard: :close_to_expiry_date?
      end
    end

    def close_to_expiry_date?
      expiry_day = expires_on.to_date
      six_months_from_today = 6.months.from_now

      expiry_day < six_months_from_today
    end

    def log_status_change
      logger.debug "Changing from #{aasm.from_state} to #{aasm.to_state} (event: #{aasm.current_event})"
    end
  end
end
