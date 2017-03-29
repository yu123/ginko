require 'json'
require 'jp_bank/filter'
module JpBank
  class BranchMap
    def initialize(bank_code)
      @bank_code = bank_code
      @data = load_data
    end

    def all
      @data
    end

    def search(query:, limit: 10)
      result = Filter.filter_with_query(@data, query, limit)
    end

    private

    def load_data
      JSON.parse(File.read(load_path)).freeze
    rescue Errno::ENOENT
      raise ArgumentError.new("#{@bank_code} is invalid for bank code")
    end

    def load_path
      File.join(File.dirname(__FILE__), "../../data/branches/#{@bank_code}.json")
    end
  end
end
