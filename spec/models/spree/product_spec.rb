require 'spec_helper'

describe Spree::Product do
  subject { build_stubbed :product }
  
  describe 'boolean attributes delegated to master' do
    %i[gs_adult gs_online_only gs_bundle].each do |attr|
      it "delegates #{attr} to master" do
        subject.send("#{attr}=", true)
        expect(subject.master.send(attr)).to be_truthy
      end
    end
  end  
  
  describe 'string attributes delegated to master' do
    %i[gs_adwords_grouping gs_adwords_labels gs_adwords_redirect gs_age_group gs_brand gs_color gs_condition gs_gender gs_gtin gs_material gs_pattern].each do |attr|
      it "delegates #{attr} to master" do
        str = Faker::Lorem.word
        subject.send("#{attr}=", str)
        expect(subject.master.send(attr)).to eq(str)
      end
    end
  end  
  
end
