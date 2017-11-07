require "rails_helper"

RSpec.describe "registrations/new", type: :view do
  before(:each) do
    assign(:registration, Registration.new(
                            regIdentifier: "Reg Identifier",
                            companyName: "Company Name New"
    ))
  end

  it "renders new registration form" do
    render

    assert_select "form[action=?][method=?]", registrations_path, "post" do

      assert_select "input#registration_regIdentifier[name=?]", "registration[regIdentifier]"

      assert_select "input#registration_companyName[name=?]", "registration[companyName]"
    end
  end
end
