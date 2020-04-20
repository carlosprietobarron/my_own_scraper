require 'docto'
require 'nokogiri'

RSpec.describe Docto do
    subject=Docto.new(Nokogiri::HTML( "<div>...</div>"))
    context "a docto object" do
    
    let(:article) {Article.new('title','http')} 

    it 'open the site smashingmag.com returning a doc object' do
        expect(subject.doc.class).to be(Nokogiri::HTML::Document)
    end

    it 'stores article item in the elements array' do
        subject.store_item('title','link')
        expect(subject.articles.count).to be > 0
    end
end
end