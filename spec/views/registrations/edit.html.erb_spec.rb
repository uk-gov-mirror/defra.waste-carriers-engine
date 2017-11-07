require "rails_helper"

RSpec.describe "registrations/edit", type: :view do
  before(:each) do
    @registration = assign(:registration, create(
                                            :registration,
                                            regIdentifier: "Reg Identifier",
                                            companyName: "Company Name Edit"
    ))
  end

  it "renders the edit registration form" do
    render

    assert_select "form[action=?][method=?]", registration_path(@registration), "post" do

      assert_select "input#registration_regIdentifier[name=?]", "registration[regIdentifier]"

      assert_select "input#registration_companyName[name=?]", "registration[companyName]"
    end
  end
end
