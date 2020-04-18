class Docto
    def initialize(doc)
        @doc=doc
        @articles=[]
    end

    def store_item(item)
        @articles.push(item)
    end
end