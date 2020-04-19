require './lib/article'

class Docto
    attr_reader :doc
    attr_reader :articles

    def initialize(doc)
        @doc = doc
        @articles = []
    end

    def store_item(title,link)
        item = Article.new(title,link)
        @articles.push(item)
    end
end