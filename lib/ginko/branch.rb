require 'json'
require 'ginko/bank_map'
require 'ginko/branch_map'
module Ginko
  class Branch
    attr_reader :name, :name_e, :name_h, :name_k, :name_kana, :code, :bank_code
    def initialize(branch_hash={})
      @bank_code = branch_hash['bank_code']
      @code = branch_hash['code']
      @name = branch_hash['name']
      @name_h = branch_hash['name_h']
      @name_k = branch_hash['name_k']
      @name_e = branch_hash['name_e']
      @routing_number = @bank_code + @code
    end

    def to_h
      {
        bank_code: @bank_code,
        code: @code,
        name: @name,
        name_h: @name_h,
        name_k: @name_k,
        name_e: @name_e,
        routing_number: @routing_number
      }
    end

    def fetch(key)
      self.respond_to?(key) ? self.send(key) : nil
    end

    def to_json
      to_h.to_json
    end
  end
end
