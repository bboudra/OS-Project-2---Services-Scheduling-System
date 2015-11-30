require 'rspec'
require_relative '../../App/registrar/dentist_office'

describe DentistOffice do
  before(:each) do
    @offices = DentistOffice.new
  end

  describe 'add_offices' do
    it 'should add office when given proper values' do
      @offices.add_office('office_that_exists_2', 2003)
      expect(@offices.get_office_port('office_that_exists_2')).to eq(2003)
    end
  end

  describe 'get_office_port' do
    before(:each) do
      @offices.add_office('office_that_exists', 2002)
    end

    context 'The specified office exists' do
      it 'should return the port 2002' do
        expect(@offices.get_office_port('office_that_exists')).to eq(2002)
      end
    end

    context 'The specified office does not exist' do
      it 'should return nil' do
        expect(@offices.get_office_port('office_that_doesnt_exist')).to be_nil
      end
    end
  end

  describe 'get_dentist_offices' do
    context 'when there are no offices' do
      before(:each) do
        @offices.clear_offices_list
      end

      it 'should be empty' do
        expect(@offices.get_dentist_offices).to eq([])
      end
    end

    context 'when only the office office3 exists' do
      before(:each) do
        @offices.clear_offices_list
        @offices.add_office('office3',2004)
      end
      it 'should return a list with only office3' do
        expect(@offices.get_dentist_offices).to eql(['office3'])
      end
    end

  end
end