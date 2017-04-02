require 'json'
require 'jp_bank/name_query'
module JpBank
  class BankMap
    include NameQuery
    load_path = File.join(File.dirname(__FILE__), '../../data/banks.json')
    @@data = JSON.parse(File.read(load_path)).freeze

    def initialize
      @result = {}
    end

    def find_by(k, v)
      bank_data = data.select {|bank| bank[k] == v }.first || {}
      bank_data.empty? ? nil : Bank.new(bank_data)
    end

    private

    def item_klass
      Bank
    end

    def data
      @@data
    end

    def result
      @result
    end
  end
end
