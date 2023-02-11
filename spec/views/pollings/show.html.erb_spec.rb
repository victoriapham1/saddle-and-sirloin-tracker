require 'rails_helper'

RSpec.describe "pollings/show", type: :view do
  before(:each) do
    assign(:polling, Polling.create!(
      question: "Question",
      answer1: "Answer1",
      answer2: "Answer2",
      answer3: "Answer3",
      answer4: "Answer4"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Question/)
    expect(rendered).to match(/Answer1/)
    expect(rendered).to match(/Answer2/)
    expect(rendered).to match(/Answer3/)
    expect(rendered).to match(/Answer4/)
  end
end
