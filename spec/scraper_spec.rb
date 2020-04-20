require 'scraper'
require 'stringio'
require 'docto'
require 'nokogiri'

RSpec.describe Scraper do


    def capture_stdout(&blk)
        old = $stdout
        $stdout = fake = StringIO.new
        blk.call
        fake.string
      ensure
        $stdout = old
      end
    
    subject=Scraper.new
    it 'gets keywords array from user input' do
        scraper_dbl=double
        allow(scraper_dbl).to receive(:get_keywords).and_return(["browser","developer"])
        expect(scraper_dbl.get_keywords).to eq(["browser","developer"])
    end

    it 'Scraps the given nokogiri doc object' do
    subject.stub(:scrap_doc) do
        html="<body><article class=\"article--post\"><h1><a \
               href=\"link\">title</a></h1></article></body>"
        parse_page=Nokogiri::HTML(html)
        anchors=parse_page.css('.article--post').css('h1 a')
        title = ''
        link = ''
        anchors.each do |liga|
            title = liga.text
            link = liga.attribute('href').text
        end
        result = "#{title} #{link}"
        print result
    end

    printed = capture_stdout do
        subject.scrap_doc
    end
   
     expect(printed).to be =='title link'

    end 

    let(:doc) {Docto.new(nil)} 
    it 'shows the resulting article in the console' do
            scrap_dbl = double
            subject.stub(:scrap_to_screen) do
                fkdoc=doc
                fkdoc.store_item('title','/link')
                fkdoc.articles.each {|art| print art.to_text.chomp}
            end
            printed = capture_stdout do
               expect(subject.scrap_to_screen)
            end
          
            expect(printed).to eq('3.- title title link: https://www.smashingmagazine.com/link')
    end
end