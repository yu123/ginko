module JpBank
  module Filter
    def self.filter_with_query(data, query, limit=10)
      data[0,limit] if query.nil? || query.empty?
      query = /\A#{query}/
      result = []
      data.each { |b|
        result << b if b['name'].match(query) ||
                       b['name_h'].match(query) ||
                       b['name_k'].match(query) ||
                       b['name_e'].match(query)
        break if result.size == limit
      }
      result
    end
  end
end
