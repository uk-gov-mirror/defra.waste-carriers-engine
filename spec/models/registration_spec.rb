require "rails_helper"

RSpec.describe Registration, type: :model do

  describe "State changes" do
    context "Given Registration is new" do
      before(:each) do
        @registration = Registration.new
      end

      it "should have 'pending' status" do
        expect(@registration).to have_state(:pending)
      end

      # Users should be able to activate or refuse the registration
      it "should be able to activate" do
        expect(@registration).to allow_event :activate
        expect(@registration).to transition_from(:pending).to(:active).on_event(:activate)
      end

      it "should be able to refuse" do
        expect(@registration).to allow_event :refuse
        expect(@registration).to transition_from(:pending).to(:refused).on_event(:refuse)
      end

      # Users should not be able to revoke or renew the registration
      it "should not be able to revoke" do
        expect(@registration).to_not allow_event :revoke
      end

      it "should not be able to renew" do
        expect(@registration).to_not allow_event :renew
      end

      # Registration should not expire straight from pending
      it "should not be able to expire" do
        expect(@registration).to_not allow_event :expire
      end

      # Registration should not change to disallowed states
      it "should not be able to transition to 'revoked', 'renewed' or 'expired'" do
        expect(@registration).to_not allow_transition_to(:revoked)
        expect(@registration).to_not allow_transition_to(:renewed)
        expect(@registration).to_not allow_transition_to(:expired)
      end
    end

    context "Given Registration is active" do
      before(:each) do
        @registration = Registration.new(status: :active)
      end

      it "should have 'active' status" do
        expect(@registration).to have_state(:active)
      end

      # Users should be able to renew or revoke the registration
      it "should be able to revoke" do
        expect(@registration).to allow_event :revoke
        expect(@registration).to transition_from(:active).to(:revoked).on_event(:revoke)
      end

      it "should be able to renew" do
        expect(@registration).to allow_event :renew
        expect(@registration).to transition_from(:active).to(:active).on_event(:renew)
      end

      # Registration should be able to expire
      it "should be able to expire" do
        expect(@registration).to allow_event :expire
        expect(@registration).to transition_from(:active).to(:expired).on_event(:expire)
      end

      # Users should not be able to refuse an already-active registration
      it "should not be able to refuse" do
        expect(@registration).to_not allow_event :refuse
      end

      # Users should not be able to activate an already-active registration
      it "should not be able to activate" do
        expect(@registration).to_not allow_event :activate
      end

      # Registration should not change to disallowed states
      it "should not be able to transition to 'pending' or 'refused'" do
        expect(@registration).to_not allow_transition_to(:pending)
        expect(@registration).to_not allow_transition_to(:refused)
      end
    end

    context "Given Registration is refused" do
      before(:each) do
        @registration = Registration.new(status: :refused)
      end

      it "should have 'refused' status" do
        expect(@registration).to have_state(:refused)
      end

      # Registration should not be able to change state again
      it "should not be able to transition" do
        expect(@registration).to_not allow_transition_to(:pending)
        expect(@registration).to_not allow_transition_to(:active)
        expect(@registration).to_not allow_transition_to(:refused)
        expect(@registration).to_not allow_transition_to(:revoked)
      end
    end

    context "Given Registration is revoked" do
      before(:each) do
        @registration = Registration.new(status: :revoked)
      end

      it "should have 'revoked' status" do
        expect(@registration).to have_state(:revoked)
      end

      # Registration should not be able to change state again
      it "should not be able to transition" do
        expect(@registration).to_not allow_transition_to(:pending)
        expect(@registration).to_not allow_transition_to(:active)
        expect(@registration).to_not allow_transition_to(:refused)
        expect(@registration).to_not allow_transition_to(:revoked)
      end
    end

    context "Given Registration is expired" do
      before(:each) do
        @registration = Registration.new(status: :expired)
      end

      it "should have 'expired' status" do
        expect(@registration).to have_state(:expired)
      end

      # Users should be able to renew expired registration
      # Probably with some limits... TODO find out about that!
      it "should be able to renew" do
        expect(@registration).to allow_event :renew
        expect(@registration).to transition_from(:expired).to(:active).on_event(:renew)
      end

      # Aside from renewal, this should stay expired
      it "should not be able to revoke" do
        expect(@registration).to_not allow_event :revoke
      end

      it "should not be able to refuse" do
        expect(@registration).to_not allow_event :refuse
      end

      # A currently-expired registration should not expire again
      it "should not be able to expire" do
        expect(@registration).to_not allow_event :expire
      end

      # Registration should not change to disallowed states
      it "should not be able to transition to 'pending', 'refused', 'revoked'" do
        expect(@registration).to_not allow_transition_to(:pending)
        expect(@registration).to_not allow_transition_to(:refused)
        expect(@registration).to_not allow_transition_to(:revoked)
      end
    end
  end

end
