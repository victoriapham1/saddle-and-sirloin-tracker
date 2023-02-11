require 'rails_helper'

RSpec.describe "pollings/new", type: :view do
  before(:each) do
    assign(:polling, Polling.new(
      question: "MyString",
      answer1: "MyString",
      answer2: "MyString",
      answer3: "MyString",
      answer4: "MyString"
    ))
  end

  it "renders new polling form" do
    render

    assert_select "form[action=?][method=?]", pollings_path, "post" do

      assert_select "input[name=?]", "polling[question]"

      assert_select "input[name=?]", "polling[answer1]"

      assert_select "input[name=?]", "polling[answer2]"

      assert_select "input[name=?]", "polling[answer3]"

      assert_select "input[name=?]", "polling[answer4]"
    end
  end
end
