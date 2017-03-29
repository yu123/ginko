require 'json'
require 'jp_bank/bank_map'
require 'jp_bank/branch_map'
module JpBank
  class Bank
    attr_reader :name, :name_e, :name_h, :name_k, :name_kana, :code, :branches
    def initialize(bank_hash={})
      @name = bank_hash['name']
      @name_h = bank_hash['name_h']
      @name_k = bank_hash['name_k']
      @name_e = bank_hash['name_e']
      @code = bank_hash['code'].to_s
    end

    def branches
      @branches ||= BranchMap.new(@code)
    end

    def to_h
      {
        code: @code,
        name: @name,
        name_h: @name_h,
        name_k: @name_k,
        name_e: @name_e
      }
    end

    def to_json
      to_h.to_json
    end

    def self.search(query:, limit: 10)
      BankMap.search(query: query, limit: limit)
    end

    def self.find(code)
      BankMap.find_by('code', code)
    end

  end
end
