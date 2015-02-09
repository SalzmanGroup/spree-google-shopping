require 'spec_helper'

describe Spree::GoogleShoppingIntegration do
  subject { build_stubbed :google_shopping_integration }
  
  it 'has many taxons' do
    expect(
      described_class.reflect_on_all_associations(:has_and_belongs_to_many).map(&:name)
    ).to include(:taxons)
  end
  
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
    
    context 'when the integration has taxons' do
      let(:taxons) { create_list(:taxon, 2, products: create_list(:product, 2)) }
      before(:each) do 
        subject.taxons = taxons 
      end
      
      it 'scopes by taxons' do
        loose_products = create_list(:product, 2)
        expect(subject.products).to_not be_empty
        expect(subject.products & loose_products).to be_empty
      end
    end
  end
end
