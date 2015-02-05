require 'spec_helper'

describe Spree::GoogleShoppingIntegration do
  subject { build_stubbed :google_shopping_integration }
  
  context 'Validations' do
    it 'has a valid factory' do
      expect(subject).to be_valid
    end
    
    it 'validates presence of name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end
    
    it 'validates presence of merchant_id' do
      subject.merchant_id = nil
      expect(subject).to_not be_valid
    end
    
    it 'validates presence of channel' do
      subject.channel = nil
      expect(subject).to_not be_valid
    end
    
    it 'validates that channel is in list' do
      subject.channel = 'not_correct'
      expect(subject).to_not be_valid
    end
    
    it 'validates presence of content_language' do
      subject.content_language = nil
      expect(subject).to_not be_valid
    end
    
    it 'validates presence of target_country' do
      subject.target_country = nil
      expect(subject).to_not be_valid
    end
    
    it 'validates presence of active' do
      subject.active = nil
      expect(subject).to_not be_valid
    end
  end
  
  describe '#products' do
    context 'when a products_scope is defined' do
      let(:products_scope) { build_stubbed(:taxon) }
      before(:each) { subject.products_scope = products_scope }
      
      it 'returns products from the products_scope' do
        expect(products_scope).to receive(:products)
        subject.products  
      end
    end
    
    context 'when a products_scope is not defined' do
      before(:each) { subject.products_scope = nil }
      
      it 'returns all products' do
        expect(Spree::Product).to receive(:all)  
        subject.products  
      end
    end
  end
end
