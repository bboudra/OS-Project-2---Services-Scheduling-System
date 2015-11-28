require_relative '../../App/client/client'
require 'rspec'

describe Client do
  before(:each) do
    @client = Client.new
  end

  describe 'convert_to_military_float' do
    context 'received a standard value on the hour' do
      it 'Should return the time 18.00' do
        expect(@client.convert_time_to_military_float('6:00:PM')).to eq(18.00)
      end
    end
    context 'received time that is not right on the hour' do
      it 'should return the time 18.25' do
        expect(@client.convert_time_to_military_float('6:15:PM')).to eq(18.25)
      end
    end

    context 'received time that is at the lower limit' do
      it 'should return the time 6.00' do
        expect(@client.convert_time_to_military_float('6:00:AM')).to eq(6.00)
      end
    end

    context 'received time that is at the upper limit' do
      it 'should return the time 20.00' do
        expect(@client.convert_time_to_military_float('8:00:PM')).to eq(20.00)
      end
    end
  end

  describe 'valid_range' do
    context 'time is in valid range and on the hour' do
      it 'should be a valid time' do
        expect(@client).to be_valid_time(10.00)
      end
    end
    context 'time is at beginning of valid range' do
      it 'should a valid time' do
        expect(@client).to be_valid_time(6.00)
      end
    end
    context 'time is at the end of valid range' do
      it 'should be a valid time' do
        expect(@client).to be_valid_time(20.00)
      end
    end
    context 'time is at the first quarter of the hour' do
      it 'should be a valid time' do
        expect(@client).to be_valid_time(10.25)
      end
    end

    context 'time is at the second quarter of the hour' do
      it 'should be a valid time' do
        expect(@client).to be_valid_time(10.50)
      end
    end

    context 'time is at the third quarter of the hour' do
      it 'should be a valid time' do
        expect(@client).to be_valid_time(10.75)
      end
    end

    context 'time is earlier the beginning of the valid range' do
      it 'should not be a valid time' do
        expect(@client).to_not be_valid_time(4.00)
      end
    end
    context 'time is later than the end of the valid range' do
      it 'should not be a valid time' do
        expect(@client).to_not be_valid_time(21.00)
      end
    end

    context 'Time is not on the quarter of the hour' do
      it 'should not be a valid time' do
        expect(@client).to_not be_valid_time(21.10)
      end
    end
  end
end
