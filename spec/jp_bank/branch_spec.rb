require 'spec_helper'

RSpec.describe JpBank::Branch do
  let(:bank) { JpBank::Bank.find('0009') }
  let(:branch) { bank.branches.search('新宿').first }
  describe 'attributes' do
    context 'valid bank' do
      it { expect(branch.bank_code).to eq('0009') }
      it { expect(branch.code).to eq('221') }
      it { expect(branch.name).to eq('新宿') }
      it { expect(branch.name_h).to eq('しんじゆく') }
      it { expect(branch.name_k).to eq('シンジユク') }
      it { expect(branch.name_e).to eq('shinjiyuku') }
      it { expect(branch.routing_number).to eq('0009221')}
    end
  end

  describe '#to_h' do
    it { expect(branch.to_h).to eq({
        bank_code: branch.bank_code,
        code: branch.code,
        name: branch.name,
        name_h: branch.name_h,
        name_k: branch.name_k,
        name_e: branch.name_e,
        routing_number: '0009221'
      })
    }
  end

  describe '#to_json' do
    it { expect(branch.to_json).to eql({
        bank_code: branch.bank_code,
        code: branch.code,
        name: branch.name,
        name_h: branch.name_h,
        name_k: branch.name_k,
        name_e: branch.name_e,
        routing_number: '0009221'
      }.to_json)
    }
  end
end
