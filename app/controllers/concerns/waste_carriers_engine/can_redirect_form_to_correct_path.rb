# frozen_string_literal: true

module WasteCarriersEngine
  module CanRedirectFormToCorrectPath
    extend ActiveSupport::Concern

    included do
      def redirect_to_correct_form
        redirect_to form_path
      end

      # Get the path based on the workflow state, with token as params, ie:
      # new_state_name_path/:token or start_state_name_path?token=:token
      def form_path
        # Corrects a routing bug by dynamically determining the correct URL for a form.
        # Tries to generate the path with `main_app`, falling back to `basic_app_engine` on failure.
        # Ensures accurate path generation in contexts where default routing may fail,
        # Workaround for creating incorrect routes when not specifying the
        # url_helpers source in the main app

        main_app.send("new_#{@transient_registration.workflow_state}_path".to_sym, token: @transient_registration.token)
      rescue NoMethodError
        basic_app_engine.send("new_#{@transient_registration.workflow_state}_path".to_sym,
                              token: @transient_registration.token)
      end
    end
  end
end
