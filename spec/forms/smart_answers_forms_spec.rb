require "rails_helper"

RSpec.describe SmartAnswersForm, type: :model do
  describe "#submit" do
    context "when the form is valid" do
      let(:smart_answers_form) { build(:smart_answers_form, :has_required_data) }
      let(:valid_params) { { reg_identifier: smart_answers_form.reg_identifier } }

      it "should submit" do
        expect(smart_answers_form.submit(valid_params)).to eq(true)
      end
    end

    context "when the form is not valid" do
      let(:smart_answers_form) { build(:smart_answers_form, :has_required_data) }
      let(:invalid_params) { { reg_identifier: "foo" } }

      it "should not submit" do
        expect(smart_answers_form.submit(invalid_params)).to eq(false)
      end
    end
  end

  describe "#reg_identifier" do
    context "when a valid transient registration exists" do
      let(:transient_registration) do
        create(:transient_registration,
               :has_required_data,
               workflow_state: "smart_answers_form")
      end
      # Don't use FactoryBot for this as we need to make sure it initializes with a specific object
      let(:smart_answers_form) { SmartAnswersForm.new(transient_registration) }

      context "when a reg_identifier meets the requirements" do
        before(:each) do
          smart_answers_form.reg_identifier = transient_registration.reg_identifier
        end

        it "is valid" do
          expect(smart_answers_form).to be_valid
        end
      end

      context "when a reg_identifier is blank" do
        before(:each) do
          smart_answers_form.reg_identifier = ""
        end

        it "is not valid" do
          expect(smart_answers_form).to_not be_valid
        end
      end
    end
  end

  describe "#transient_registration" do
    context "when the transient registration is invalid" do
      let(:transient_registration) do
        build(:transient_registration,
              workflow_state: "smart_answers_form")
      end
      # Don't use FactoryBot for this as we need to make sure it initializes with a specific object
      let(:smart_answers_form) { SmartAnswersForm.new(transient_registration) }

      before(:each) do
        # Make reg_identifier valid for the form, but not the transient object
        smart_answers_form.reg_identifier = transient_registration.reg_identifier
        transient_registration.reg_identifier = "foo"
      end

      it "is not valid" do
        expect(smart_answers_form).to_not be_valid
      end

      it "inherits the errors from the transient_registration" do
        smart_answers_form.valid?
        expect(smart_answers_form.errors[:base]).to include(I18n.t("mongoid.errors.models.transient_registration.attributes.reg_identifier.invalid_format"))
      end
    end
  end
end
