require_relative '../../spec_helper'

RSpec.describe UmnShibAuth::Session do
  let(:subject)      { UmnShibAuth::Session.new(eppn: eppn, emplid: emplid, display_name: display_name) }
  let(:internet_id)  { SecureRandom.hex[0, 7] }
  let(:eppn)         { "#{internet_id}@blah.edu" }
  let(:emplid)       { rand(10**7).to_s.rjust(7, '0') }
  let(:display_name) { SecureRandom.hex }

  describe 'with valid data' do
    describe :emplid do
      it 'is set' do
        expect(subject).to respond_to(:emplid)
        expect(subject.emplid).to eq(emplid)
      end
    end

    describe :display_name do
      it 'is set' do
        expect(subject).to respond_to(:display_name)
        expect(subject.display_name).to eq(display_name)
      end
    end
  end

  describe 'with missing data' do
    describe 'missing display_name' do
      it 'does not raise an error' do
        expect { UmnShibAuth::Session.new(eppn: eppn, emplid: emplid, display_name: nil) }.not_to raise_error
      end

      it 'leaves emplid as nil' do
        expect(UmnShibAuth::Session.new(eppn: eppn, emplid: emplid, display_name: nil).display_name).to be_nil
      end
    end

    describe 'missing emplid' do
      it 'does not raise an error' do
        expect { UmnShibAuth::Session.new(eppn: eppn, emplid: nil, display_name: display_name) }.not_to raise_error
      end

      it 'leaves emplid as nil' do
        expect(UmnShibAuth::Session.new(eppn: eppn, emplid: nil, display_name: display_name).emplid).to be_nil
      end
    end
  end

  describe "with additional shib session data" do
    let(:additional_shib_data) { {} }

    subject do
      described_class.new(
        {
          eppn: eppn,
          emplid: emplid,
          display_name: display_name,
        },
        additional_shib_data
      )
    end

    describe "when one of the keys is an invalid instance variable name" do
      before do
        additional_shib_data.merge("Shib-Handler": "test")
      end

      it "would fail if it tries to set the instance variable" do
        expect { subject.instance_varible_set("@Shib-Handler") }.to raise_error(NameError)
      end

      it "does not set that instance variable" do
        expect(subject.instance_variables).not_to include("Shib-Handler")
      end
    end
  end
end
