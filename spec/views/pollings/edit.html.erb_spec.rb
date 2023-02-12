require 'rails_helper'

RSpec.describe "pollings/edit", type: :view do
  let(:polling) {
    Polling.create!(
      question: "MyString",
      answer1: "MyString",
      answer2: "MyString",
      answer3: "MyString",
      answer4: "MyString"
    )
  }

  before(:each) do
    assign(:polling, polling)
  end

  it "renders the edit polling form" do
    render

    assert_select "form[action=?][method=?]", polling_path(polling), "post" do

      assert_select "input[name=?]", "polling[question]"

      assert_select "input[name=?]", "polling[answer1]"

      assert_select "input[name=?]", "polling[answer2]"

      assert_select "input[name=?]", "polling[answer3]"

      assert_select "input[name=?]", "polling[answer4]"
    end
  end
end
