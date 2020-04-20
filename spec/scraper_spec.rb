require 'scraper'

RSpec.describe Scraper do
    subject=Scraper.new
    it 'gets keywords array from user input' do
        scraper_dbl=double
        allow(scraper_dbl).to receive(:get_keywords).and_return(["browser","developer"])
        expect(scraper_dbl.get_keywords).to eq(["browser","developer"])
    end

    it 'open https://smashingmag.com gets document' do
        pending("something else getting finished")
        this_should_not_get_executed
    end

    it 'gets nodes from doc based on keywords' do
        pending("something else getting finished")
        this_should_not_get_executed
    end

    it 'shows the resulting article in the console' do
        pending("something else getting finished")
        this_should_not_get_executed 
    end
end