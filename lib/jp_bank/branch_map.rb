require 'json'
require 'jp_bank/name_query'
require 'jp_bank/branch'
module JpBank
  class BranchMap
    include NameQuery
    def initialize(bank_code)
      @bank_code = bank_code
      @data = load_data
      @result = {}
    end

    def all
      @data
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

    def item_klass
      Branch
    end

    def data
      @data
    end

    def result
      @result
    end
  end
end
