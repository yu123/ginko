require 'json'
require 'jp_bank/bank_map'
require 'jp_bank/branch_map'
module JpBank
  class Bank
    attr_reader :name, :name_e, :name_h, :name_k, :name_kana, :code
    def initialize(bank_hash={})
      @name = bank_hash.fetch('name')
      @name_h = bank_hash.fetch('name_h')
      @name_k = bank_hash.fetch('name_k')
      @name_e = bank_hash.fetch('name_e')
      @code = bank_hash.fetch('code').to_s
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

    def fetch(key)
      self.respond_to?(key) ? self.send(key) : nil
    end

    def self.search(query, options={})
      mapper.search(query, options)
    end

    def self.find(code)
      mapper.find_by('code', code)
    end

    def self.mapper
      @@mapper ||= BankMap.new
    end
  end
end
