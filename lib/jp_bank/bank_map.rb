require 'json'

module JpBank
  class BankMap
    load_path = File.join(File.dirname(__FILE__), '../../data/banks.json')
    @@data = JSON.parse(File.read(load_path)).freeze
    def self.data
      @@data
    end

    def self.search(query:, limit: 10)
      result = Filter.filter_with_query(data, query, limit)
      result.map{ |r| Bank.new(r) }
    end

    def self.find_by(k, v)
      bank_data = data.select {|bank| bank[k] == v }.first || {}
      bank_data.empty? ? nil : Bank.new(bank_data)
    end
  end
end
