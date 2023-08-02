# require 'rails_helper'

# RSpec.describe CookCookiesJob, type: :job do
#   let(:oven) { create(:oven) }

#   it 'updates the state of cookies to "cooked" after cooking' do
#     cookies = create_list(:cookie, 12, :ready_to_cook, oven: oven)

#     expect {
#       perform_enqueued_jobs { CookCookiesJob.perform_later(oven) }
#       cookies.reload
#     }.to change { cookies.pluck(:state) }.from(['ready_to_cook']).to(['cooked'])
#   end
# end
