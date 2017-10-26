require "rails_helper"

RSpec.describe Registration, type: :model do

  describe "#status" do
    context "when a registration is created" do
      let(:registration) { Registration.new }

      it "has 'pending' status" do
        expect(registration).to have_state(:pending)
      end
    end

    context "when a registration is pending" do
      let(:registration) { Registration.new(status: :pending) }

      it "has 'pending' status" do
        expect(registration).to have_state(:pending)
      end

      it "can be activated" do
        expect(registration).to allow_event :activate
        expect(registration).to transition_from(:pending).to(:active).on_event(:activate)
      end

      it "can be refused" do
        expect(registration).to allow_event :refuse
        expect(registration).to transition_from(:pending).to(:refused).on_event(:refuse)
      end

      it "cannot be revoked" do
        expect(registration).to_not allow_event :revoke
      end

      it "cannot be renewed" do
        expect(registration).to_not allow_event :renew
      end

      it "cannot expire" do
        expect(registration).to_not allow_event :expire
      end

      it "cannot transition to 'revoked', 'renewed' or 'expired'" do
        expect(registration).to_not allow_transition_to(:revoked)
        expect(registration).to_not allow_transition_to(:renewed)
        expect(registration).to_not allow_transition_to(:expired)
      end
    end

    context "when a registration is active" do
      let(:registration) { Registration.new(status: :active) }

      it "has 'active' status" do
        expect(registration).to have_state(:active)
      end

      it "can be revoked" do
        expect(registration).to allow_event :revoke
        expect(registration).to transition_from(:active).to(:revoked).on_event(:revoke)
      end

      it "can be renewed" do
        expect(registration).to allow_event :renew
        expect(registration).to transition_from(:active).to(:active).on_event(:renew)
      end

      it "can expire" do
        expect(registration).to allow_event :expire
        expect(registration).to transition_from(:active).to(:expired).on_event(:expire)
      end

      it "cannot be refused" do
        expect(registration).to_not allow_event :refuse
      end

      it "cannot be activated" do
        expect(registration).to_not allow_event :activate
      end

      it "cannot transition to 'pending' or 'refused'" do
        expect(registration).to_not allow_transition_to(:pending)
        expect(registration).to_not allow_transition_to(:refused)
      end
    end

    context "when a registration is refused" do
      let(:registration) { Registration.new(status: :refused) }

      it "has 'refused' status" do
        expect(registration).to have_state(:refused)
      end

      it "cannot transition to other states" do
        expect(registration).to_not allow_transition_to(:pending)
        expect(registration).to_not allow_transition_to(:active)
        expect(registration).to_not allow_transition_to(:refused)
        expect(registration).to_not allow_transition_to(:revoked)
      end
    end

    context "when a registration is revoked" do
      let(:registration) { Registration.new(status: :revoked) }

      it "has 'revoked' status" do
        expect(registration).to have_state(:revoked)
      end

      it "cannot transition to other states" do
        expect(registration).to_not allow_transition_to(:pending)
        expect(registration).to_not allow_transition_to(:active)
        expect(registration).to_not allow_transition_to(:refused)
        expect(registration).to_not allow_transition_to(:revoked)
      end
    end

    context "when a registration is expired" do
      let(:registration) { Registration.new(status: :expired) }

      it "has 'expired' status" do
        expect(registration).to have_state(:expired)
      end

      # Users are able to renew expired registration
      # Probably with some limits... TODO find out about that!
      it "can renew" do
        expect(registration).to allow_event :renew
        expect(registration).to transition_from(:expired).to(:active).on_event(:renew)
      end

      it "cannot be revoked" do
        expect(registration).to_not allow_event :revoke
      end

      it "cannot be refused" do
        expect(registration).to_not allow_event :refuse
      end

      it "cannot expire" do
        expect(registration).to_not allow_event :expire
      end

      it "cannot transition to 'pending', 'refused', 'revoked'" do
        expect(registration).to_not allow_transition_to(:pending)
        expect(registration).to_not allow_transition_to(:refused)
        expect(registration).to_not allow_transition_to(:revoked)
      end
    end
  end
end
