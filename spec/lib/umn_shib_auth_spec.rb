# frozen_string_literal: true

require_relative '../spec_helper'
require 'fileutils'
require 'securerandom'

# rubocop:disable Style/StringLiterals, Metrics/BlockLength
RSpec.describe UmnShibAuth do
  let(:internet_id) { SecureRandom.hex[0, 8] }
  let(:emplid) { rand(10**7).to_s.rjust(7, '0') }
  let(:display_name) { SecureRandom.hex }

  describe '.set_global_defaults!' do
    it 'set values correctly' do
      described_class.set_global_defaults!
      expect(described_class.eppn_variable).to eq('eppn')
      expect(described_class.emplid_variable).to eq('umnEmplId')
      expect(described_class.display_name_variable).to eq('displayName')
    end
  end

  describe ".using_stub_internet_id?" do
    context "ENV[STUB_INTERNET_ID] is set'" do
      before do
        ENV["STUB_INTERNET_ID"] = rand(1..999).to_s
      end

      after do
        ENV.delete("STUB_INTERNET_ID")
      end

      it "allows stubbing in the development environment" do
        allow(Rails).to receive(:env).and_return("development")
        expect(described_class.stubbing_enabled?).to be true
      end

      it "allows stubbing in the test environment" do
        expect(described_class.stubbing_enabled?).to be true
      end

      it "disallows stubbing in the production environment" do
        allow(Rails).to receive(:env).and_return("production")
        expect(described_class.stubbing_enabled?).to be false
      end

      it "disallows stubbing in the any non-test/dev environment" do
        allow(Rails).to receive(:env).and_return("some_non_standard_env")
        expect(described_class.stubbing_enabled?).to be false
      end
    end
  end

  describe "use stub environment variables" do
    context "with set stub environment values" do
      before do
        ENV["STUB_INTERNET_ID"] = internet_id
        ENV["STUB_EMPLID"] = emplid
        ENV["STUB_DISPLAY_NAME"] = display_name
        allow(Rails).to receive(:root).and_return('/dev/null')
      end

      after do
        ENV.delete("STUB_INTERNET_ID")
        ENV.delete("STUB_EMPLID")
        ENV.delete("STUB_DISPLAY_NAME")
      end

      describe ".stub_internet_id" do
        it "raises an error in a non dev/test environment" do
          allow(Rails).to receive(:env).and_return("production")
          expect { described_class.stub_internet_id }.to raise_error(UmnShibAuth::StubbingNotEnabled)
        end

        it "returns stub internet id in a dev/test environment" do
          expect(described_class.stub_internet_id).to eq(internet_id)
        end
      end

      describe ".stub_emplid" do
        it "raises an error in a non dev/test environment" do
          allow(Rails).to receive(:env).and_return("production")
          expect { described_class.stub_emplid }.to raise_error(UmnShibAuth::StubbingNotEnabled)
        end

        it "returns stub internet id in a dev/test enviroment" do
          expect(described_class.stub_emplid).to eq(emplid)
        end

        context "with blank stub emplid" do
          before do
            ENV.delete("STUB_EMPLID")
          end

          it "does not throw an error" do
            expect { described_class.stub_emplid }.not_to raise_error
          end

          it "returns nil" do
            expect(described_class.stub_emplid).to be_nil
          end
        end
      end

      describe ".stub_display_name" do
        it "raises an error in a non dev/test environment" do
          allow(Rails).to receive(:env).and_return("staging")
          expect { described_class.stub_display_name }.to raise_error(UmnShibAuth::StubbingNotEnabled)
        end

        it "returns stub display name in a dev/test environment" do
          expect(described_class.stub_display_name).to eq(display_name)
        end

        context "with blank stub display_name" do
          before do
            ENV.delete("STUB_DISPLAY_NAME")
          end

          it "does not throw an error" do
            expect { described_class.stub_display_name }.not_to raise_error
          end

          it "returns nil" do
            expect(described_class.stub_display_name).to be_nil
          end
        end
      end
    end
  end

 # rubocop:enable Metrics/BlockLength
  context 'Using stubbed attributes yml' do
    it 'Can load stubbed attributes' do
      stubbed_attributes = described_class.stubbed_attributes
      expect(stubbed_attributes).to_not be_empty
      expect(stubbed_attributes['eppn']).to eq('jenny@umn.edu')
      expect(stubbed_attributes['displayName']).to eq('Jenny')
      expect(stubbed_attributes['umnEmplId']).to eq('8675309')
    end

    it 'If file does not exist, do not load' do
      allow(Rails).to receive(:root).and_return('/dev/null')
      stubbed_attributes = described_class.stubbed_attributes
      expect(stubbed_attributes).to be_empty
    end

    it 'If stubbing is not enabled, do not load' do
      expect(described_class).to receive(:stubbing_enabled?).and_return(false)
      expect(described_class.stubbed_attributes).to be_empty
    end
  end

  context 'Use stubbed attributes over ENV variables' do
    it 'Stubbed attributes can split out internet_id' do
      expect(described_class.parsed_internet_id).to eq 'jenny'
    end

    it 'No stubbed attributes will return nil parsed internet id' do
      allow(Rails).to receive(:root).and_return('/dev/null')
      expect(described_class.parsed_internet_id).to be nil
    end

    it 'using_stub_internet_id? will trigger with stubbed attribute' do
      expect(described_class.using_stub_internet_id?).to be true
    end

    it 'Stubbed Display name is Jenny' do
      expect(described_class.stub_display_name).to eq('Jenny')
    end

    it 'Stubbed internet_id is jenny' do
      expect(described_class.stub_internet_id).to eq('jenny')
    end

    it 'Stubbed emplid is 8675309' do
      expect(described_class.stub_emplid).to eq('8675309')
    end
  end
end
# rubocop:enable Style/StringLiterals, Metrics/BlockLength
