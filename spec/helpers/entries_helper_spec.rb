require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the EntriesHelper. For example:
#
# describe EntriesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe EntriesHelper, type: :helper do
  describe "seconds_to_time" do
    it "converts seconds to time" do
      expect(seconds_to_time(0)).to eq("00:00:00")
      expect(seconds_to_time(35)).to eq("00:00:35")
      expect(seconds_to_time(61)).to eq("00:01:01")
      expect(seconds_to_time(3661)).to eq("01:01:01")
    end
  end
end
