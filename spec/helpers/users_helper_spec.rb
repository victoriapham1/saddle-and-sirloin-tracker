require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the UsersHelper. For example:
#
describe UsersHelper do
     describe "sunny day" do
          it "the event created should show on the google calendar page" do
               event = Event.new(name: "Cookout", date: '12/12/2012', description: "cookout where you can meet fellow members.").save

               gets '/calendar'
               expect(page).to(have_content("Cookout"))
          end
     end
end

# Currently do not utilize the UsersHelper
# RSpec.describe UsersHelper, type: :helper do
#   pending "add some examples to (or delete) #{__FILE__}"
# end
