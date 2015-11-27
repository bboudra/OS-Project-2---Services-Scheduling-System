require_relative '../../App/client/client'
require 'rspec'

describe Client do
  @client = Client.new
  describe 'convert_to_military_float' do
    context 'received time that is within the appropriate time range' do
      expect(@client.convert_time_to_military_float('6:00:PM')).to eq(18.00)
      expect(@client.convert_time_to_military_float('6:15:PM')).to eq(18.25)
      expect(@client.convert_time_to_military_float('6:00:AM')).to eq(6.25)
      expect(@client.convert_time_to_military_float('8:00:PM')).to eq(20.00)
    end
  end

end