require 'spec_helper'

RSpec.describe JpBank::BranchMap do

  describe '#initialize' do
    subject { described_class.new(bank_code) }
    context 'with valid bank_code' do
      let(:bank_code) { '0001' }
      it { is_expected.to be_a_kind_of(described_class) }
    end

    context 'with invalid bank_code' do
      let(:bank_code) { '1' }
      it { expect { subject }.to raise_error(ArgumentError, '1 is invalid for bank code') }
    end
  end

  describe '#search' do
    let(:bank) { JpBank::Bank.find('0009') }
    subject { bank.branches.search(query) }
    context 'with query' do
      let(:query) { '本' }
      it { is_expected.to be_a_kind_of(Array) }
      it 'contains query' do
        expect(subject.size).to be <= 3
        expect(subject.first).to be_a_kind_of(JpBank::Branch)
        expect(subject.map(&:name)).to include('本八幡')
      end

      context 'with limit option' do
        subject { bank.branches.search(query, options) }
        let(:options) { { limit: 1 } }
        it 'returns array with 1 item' do
          expect(subject.size).to eq(1)
        end
      end
    end

    context 'without query' do
      let(:query) { '' }
      it { is_expected.to be_a_kind_of(Array) }
      it 'contains 10 results' do
        expect(subject.size).to eq(10)
        expect(subject.first).to be_a_kind_of(JpBank::Branch)
      end
    end
  end
end
