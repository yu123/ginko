module Ginko
  module NameQuery

    def search(query, options={})
      limit = options[:limit] || 10
      if query.nil? || query.empty?
        # parse after limiting number of items for performance reason
        parse(data.take(limit))
      else
        result[query] if cached?(query)
        parse(update(query)).take(limit)
      end
    end

    private

    def filter_with_query(data, query)
      data if query.nil? || query.empty?
      query = /\A#{query}/
      filtered = data.select do |item|
        item.fetch('name').match(query) ||
        item.fetch('name_h').match(query) ||
        item.fetch('name_k').match(query) ||
        item.fetch('name_e').match(query)
      end
    end

    def parse(data)
      data.map do |item|
        item.is_a?(item_klass) ? item : item_klass.new(item)
      end
    end

    def cached?(query)
      result[query].nil?
    end

    def scope(query)
      matched_query = result.keys.select do |key|
        query.include?(key.to_s)
      end.sort.last
      return data if matched_query.nil? || matched_query.empty?
      @result[matched_query]
    end

    def update(query)
      scoped = scope(query)
      result[query] = filter_with_query(scoped, query)
    end

    def item_klass
      raise 'Called abstract method'
    end

    def result
      raise 'Called abstract method'
    end

    def data
      raise 'Called abstract method'
    end

  end
end
