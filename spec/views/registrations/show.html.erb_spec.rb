require "rails_helper"

RSpec.describe "registrations/show", type: :view do
  before(:each) do
    @registration = assign(:registration, create(
                                            :registration,
                                            regIdentifier: "Reg Identifier",
                                            companyName: "Company Name Show"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Reg Identifier/)
    expect(rendered).to match(/Company Name Show/)
  end
end
