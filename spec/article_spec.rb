require 'article'

RSpec.describe Article do
  subject = Article.new('this is title', 'http://this.is-link.com')
  it 'has an title' do
    expect(subject.title.class).to eq(String)
  end
  it 'has an index' do
    expect(subject.index.class).to eq(Integer)
  end
  it 'has an url' do
    expect(subject.url.include?('https://')).to be(true)
  end
  it 'return a text-formatted article' do
    expect(subject.to_text.class).to eq(String)
  end
  it 'return a html-formatted article' do
    expect(subject.to_html.include?('https://')).to be(true)
  end
end
