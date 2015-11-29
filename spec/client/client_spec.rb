require_relative '../../App/client/client'
require_relative '../../lib/utilities/utilities'
require_relative '../../lib/shared/doctors'
require_relative '../../lib/shared/appointments'
require 'date'
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

  describe 'valid_time?' do
    context 'time is in valid range and on the hour' do
      it 'should be a valid time' do
        expect(@client).to be_valid_time("10:00 AM")
      end
    end
    context 'time is at beginning of valid range' do
      it 'should a valid time' do
        expect(@client).to be_valid_time("06:00 AM")
      end
    end
    context 'time is at the end of valid range' do
      it 'should be a valid time' do
        expect(@client).to be_valid_time("07:45 PM")
      end
    end
    context 'time is at the first quarter of the hour' do
      it 'should be a valid time' do
        expect(@client).to be_valid_time("10:15 AM")
      end
    end

    context 'time is at the second quarter of the hour' do
      it 'should be a valid time' do
        expect(@client).to be_valid_time("10:30 AM")
      end
    end

    context 'time is at the third quarter of the hour' do
      it 'should be a valid time' do
        expect(@client).to be_valid_time("10:45 AM")
      end
    end

    context 'time is earlier the beginning of the valid range' do
      it 'should not be a valid time' do
        expect(@client).to_not be_valid_time("04:00 AM")
      end
    end
    context 'time is later than the end of the valid range' do
      it 'should not be a valid time' do
        expect(@client).to_not be_valid_time("09:00 PM")
      end
    end

    context 'Time is not on the quarter of the hour' do
      it 'should not be a valid time' do
        expect(@client).to_not be_valid_time("10:05 AM")
      end
    end
  end

  describe 'valid_date?' do
    before(:each) do
      @util = Utilities.new
    end
    date = Date.new
    context 'the date is of valid format and range' do
      it 'should be a valid date' do
        expect(@client).to be_an_valid_date(Date.today.next_year.strftime("%m/%d/%Y"))
      end
    end

    context 'the date isnt at the beginning of the valid date' do
      it 'should be a valid day' do
        expect(@client).to be_an_valid_date(Date.today.next.strftime("%m/%d/%Y"))
      end
    end

    context 'the date is to early' do
      it 'should not be a valid day' do
        expect(@client).to_not be_an_valid_date(Date.today.prev_day.strftime("%m/%d/%Y"))
      end
    end

    context 'the date is not a valid day' do
      it 'should not be a valid day' do
        expect(@client).to_not be_an_valid_date("11/12/15")
      end
    end
  end

  describe 'convert_time_to_military_float?' do
    before(:each) do
      @util = Utilities.new
    end
    context 'the time is 10:00 AM' do
      it 'should return 10.0' do
        @client.convert_time_to_military_float("10:00 AM")
      end
    end

    context 'the time is 6:00 AM' do
      it 'should return 6.00' do
        @client.convert_time_to_military_float("06:00 AM")
      end
    end
    context 'The time is 7:45 AM' do
      it 'should return 19.75' do
        @client.convert_time_to_military_float("07:45 PM")
      end
    end
    context 'the time is 6:15 AM' do
      it 'should return 6.25' do
        @client.convert_time_to_military_float("06:15 AM")
      end
      context 'the time is 12:30 PM' do
        it 'should return 12.50' do
          @client.convert_time_to_military_float("06:15 AM")
        end
      end
    end
  end
  describe 'valid_doctor?' do
    before(:each) do
      @util = Utilities.new
      @doctors = Doctors.new
      @doctors_list = @doctors.get_doctors
    end

    context 'the doctor is the fist spot in the list' do
      it 'should evaluate as valid' do
        expect(@client).to be_valid_doctor(@doctors_list[0])
      end
    end

    context 'the doctor is in the last spot in list' do
      it 'the doctor should be valid' do
        expect(@client).to be_valid_doctor(@doctors_list[@doctors_list.size-1])
      end
    end

    context 'the doctor is in the middle of the list' do
      it 'the doctor should be valid' do
        expect(@client).to be_valid_doctor(@doctors_list[((@doctors_list.size-1)/2).to_i])
      end
    end

    context 'the doctor does not exist' do
      it 'the doctor should not be valid' do
        expect(@client).to_not be_valid_doctor('Not a doctor')
      end
    end
    context 'the doctor does not exist' do
      it 'no name was entered' do
        expect(@client).to_not be_valid_doctor('')
      end
    end
  end

  describe 'valid_appointment_type?' do
    before(:each) do
      @util = Utilities.new
      @appointments = Appointments.new
      @appointment_keys = @appointments.get_appointment_types
    end

    context 'the appointment is the first appointment in the appointments array' do
      it 'should be a valid appointment type' do
        expect(@client).to be_valid_appointment_type(@appointment_keys[0])
      end
    end

    context 'the appointment is the last appointment in the appointments array' do
      it 'should be a valid appointment type' do
        expect(@client).to be_valid_appointment_type(@appointment_keys[@appointment_keys.size - 1])
      end
    end
    context 'the appointment is in the middle of the appointments array' do
      it 'should be a valid appointment type' do
        expect(@client).to be_valid_appointment_type(@appointment_keys[((@appointment_keys.size - 1)/2).to_i])
      end
    end
    context 'the appointment does not exist' do
      it 'should be a valid appointment type' do
        expect(@client).to_not be_valid_appointment_type("key does not exist")
      end
    end
    context 'no appointment was provided' do
      it 'should be a valid appointment type' do
        expect(@client).to_not be_valid_appointment_type("")
      end
    end
  end

end
