require 'rails_helper'

RSpec.describe "pollings/index", type: :view do
  before(:each) do
    assign(:pollings, [
      Polling.create!(
        question: "Question",
        answer1: "Answer1",
        answer2: "Answer2",
        answer3: "Answer3",
        answer4: "Answer4"
      ),
      Polling.create!(
        question: "Question",
        answer1: "Answer1",
        answer2: "Answer2",
        answer3: "Answer3",
        answer4: "Answer4"
      )
    ])
  end

  it "renders a list of pollings" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Question".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Answer1".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Answer2".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Answer3".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Answer4".to_s), count: 2
  end
end
