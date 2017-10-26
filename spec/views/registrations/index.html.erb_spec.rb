require 'rails_helper'

RSpec.describe "registrations/index", type: :view do
  before(:each) do
    assign(:registrations, [
      Registration.create!(
        :reg_identifier => "Reg Identifier",
        :company_name => "Company Name"
      ),
      Registration.create!(
        :reg_identifier => "Reg Identifier",
        :company_name => "Company Name"
      )
    ])
  end

  it "renders a list of registrations" do
    render
    assert_select "tr>td", :text => "Reg Identifier".to_s, :count => 2
    assert_select "tr>td", :text => "Company Name".to_s, :count => 2
  end
end
