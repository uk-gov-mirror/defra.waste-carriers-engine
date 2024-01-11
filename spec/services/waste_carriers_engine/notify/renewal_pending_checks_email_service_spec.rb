# frozen_string_literal: true

require "rails_helper"

module WasteCarriersEngine
  module Notify

    # TODO: Refactor to remove the use of allow_any_instance_of
    # rubocop:disable RSpec/AnyInstance
    RSpec.describe RenewalPendingChecksEmailService do
      let(:template_id) { "d2442022-4f4c-4edd-afc5-aaa0607dabdf" }
      let(:reg_identifier) { registration.reg_identifier }
      let(:expected_notify_options) do
        {
          email_address: "foo@example.com",
          template_id: template_id,
          personalisation: {
            reg_identifier: reg_identifier,
            registration_type: "carrier, broker and dealer"
          }
        }
      end
      let(:registration) { create(:registration, :has_required_data) }

      before do
        registration.finance_details = build(:finance_details, :has_required_data)
        registration.save
      end

      describe ".run" do
        context "with a contact_email" do
          before do
            allow_any_instance_of(Notifications::Client)
              .to receive(:send_email)
              .with(expected_notify_options)
              .and_call_original
          end

          subject(:run_service) do
            VCR.use_cassette("notify_renewal_pending_checks_sends_an_email") do
              described_class.run(registration: registration)
            end
          end

          let(:recipient) { registration.contact_email }

          context "when run on a registration" do

            it "sends an email" do
              expect(run_service).to be_a(Notifications::Client::ResponseNotification)
              expect(run_service.template["id"]).to eq(template_id)
              expect(run_service.content["subject"]).to match(
                /Your application to renew waste carriers registration CBDU\d has been received/
              )
            end

            it_behaves_like "can create a communication record", "email"
          end

          context "with no contact_email" do
            before { registration.contact_email = nil }

            it "does not attempt to send an email" do
              expect_any_instance_of(Notifications::Client).not_to receive(:send_email)

              described_class.run(registration: registration)
            end
          end

          context "when run on a registration renewal" do
            let(:registration) { create(:renewing_registration, :has_required_data, contact_email: "foo@example.com") }

            it_behaves_like "can create a communication record", "email"
          end
        end
      end
    end
    # rubocop:enable RSpec/AnyInstance
  end
end
