require "rails_helper"

RSpec.describe Registration, type: :model do

  describe "#status" do
    context "when a registration is created" do
      let(:registration) { build(:registration) }

      it "has 'pending' status" do
        expect(registration.metaData).to have_state(:pending)
      end
    end

    context "when a registration is pending" do
      let(:registration) { build(:registration, :is_pending) }

      it "has 'pending' status" do
        expect(registration.metaData).to have_state(:pending)
      end

      it "can be activated" do
        expect(registration.metaData).to allow_event :activate
        expect(registration.metaData).to transition_from(:pending).to(:active).on_event(:activate)
      end

      it "can be refused" do
        expect(registration.metaData).to allow_event :refuse
        expect(registration.metaData).to transition_from(:pending).to(:refused).on_event(:refuse)
      end

      it "cannot be revoked" do
        expect(registration.metaData).to_not allow_event :revoke
      end

      it "cannot be renewed" do
        expect(registration.metaData).to_not allow_event :renew
      end

      it "cannot expire" do
        expect(registration.metaData).to_not allow_event :expire
      end

      it "cannot transition to 'revoked', 'renewed' or 'expired'" do
        expect(registration.metaData).to_not allow_transition_to(:revoked)
        expect(registration.metaData).to_not allow_transition_to(:renewed)
        expect(registration.metaData).to_not allow_transition_to(:expired)
      end
    end

    context "when a registration is activated" do
      let(:registration) { build(:registration, :is_pending) }

      it "sets expiresOn 3 years in the future" do
        expect(registration.expiresOn).to be_nil
        registration.metaData.activate
        # Use .to_i to ignore milliseconds when comparing time
        expect(registration.expiresOn.to_i).to eq(3.years.from_now.to_i)
      end
    end

    context "when a registration is active" do
      let(:registration) { build(:registration, :has_expiresOn, :is_active) }

      it "has 'active' status" do
        expect(registration.metaData).to have_state(:active)
      end

      it "can be revoked" do
        expect(registration.metaData).to allow_event :revoke
        expect(registration.metaData).to transition_from(:active).to(:revoked).on_event(:revoke)
      end

      it "can expire" do
        expect(registration.metaData).to allow_event :expire
        expect(registration.metaData).to transition_from(:active).to(:expired).on_event(:expire)
      end

      it "cannot be refused" do
        expect(registration.metaData).to_not allow_event :refuse
      end

      it "cannot be activated" do
        expect(registration.metaData).to_not allow_event :activate
      end

      it "cannot transition to 'pending' or 'refused'" do
        expect(registration.metaData).to_not allow_transition_to(:pending)
        expect(registration.metaData).to_not allow_transition_to(:refused)
      end

      context "when the registration expiration date is more than 6 months away" do
        let(:registration) { build(:registration, :is_active, expiresOn: 1.year.from_now) }

        it "cannot be renewed" do
          expect(registration.metaData).to_not allow_event :renew
        end
      end

      context "when the registration expiration date is less than 6 months away" do
        let(:registration) { build(:registration, :is_active, expiresOn: 1.month.from_now) }

        it "can be renewed" do
          expect(registration.metaData).to allow_event :renew
          expect(registration.metaData).to transition_from(:active).to(:active).on_event(:renew)
        end
      end

      context "when a registration is renewed" do
        let(:registration) { build(:registration, :is_active, expiresOn: 1.month.from_now) }

        it "extends expiresOn by 3 years" do
          old_expiry_date = registration.expiresOn
          registration.metaData.renew
          new_expiry_date = registration.expiresOn

          # Use .to_i to ignore milliseconds when comparing time
          expect(new_expiry_date.to_i).to eq((old_expiry_date + 3.years).to_i)
        end
      end
    end

    context "when a registration is refused" do
      let(:registration) { build(:registration, :is_refused) }

      it "has 'refused' status" do
        expect(registration.metaData).to have_state(:refused)
      end

      it "cannot transition to other states" do
        expect(registration.metaData).to_not allow_transition_to(:pending)
        expect(registration.metaData).to_not allow_transition_to(:active)
        expect(registration.metaData).to_not allow_transition_to(:refused)
        expect(registration.metaData).to_not allow_transition_to(:revoked)
      end
    end

    context "when a registration is revoked" do
      let(:registration) { build(:registration, :is_revoked) }

      it "has 'revoked' status" do
        expect(registration.metaData).to have_state(:revoked)
      end

      it "cannot transition to other states" do
        expect(registration.metaData).to_not allow_transition_to(:pending)
        expect(registration.metaData).to_not allow_transition_to(:active)
        expect(registration.metaData).to_not allow_transition_to(:refused)
        expect(registration.metaData).to_not allow_transition_to(:revoked)
      end
    end

    context "when a registration is expired" do
      let(:registration) { build(:registration, :is_expired, expiresOn: 1.month.ago) }

      it "has 'expired' status" do
        expect(registration.metaData).to have_state(:expired)
      end

      # Users are able to renew expired registration
      # Probably with some limits... TODO find out about that!
      it "can renew" do
        expect(registration.metaData).to allow_event :renew
        expect(registration.metaData).to transition_from(:expired).to(:active).on_event(:renew)
      end

      it "cannot be revoked" do
        expect(registration.metaData).to_not allow_event :revoke
      end

      it "cannot be refused" do
        expect(registration.metaData).to_not allow_event :refuse
      end

      it "cannot expire" do
        expect(registration.metaData).to_not allow_event :expire
      end

      it "cannot transition to 'pending', 'refused', 'revoked'" do
        expect(registration.metaData).to_not allow_transition_to(:pending)
        expect(registration.metaData).to_not allow_transition_to(:refused)
        expect(registration.metaData).to_not allow_transition_to(:revoked)
      end
    end
  end
end
