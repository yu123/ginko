require 'spec_helper'

RSpec.describe JpBank::Bank do
  describe 'class_methods' do
    describe '#find' do
      subject { described_class.find(code) }
      context 'when a bank exists' do
        let(:code) { '0001' }
        it {
          is_expected.to be_a_kind_of(JpBank::Bank)
          expect(subject.name).to eq('みずほ')
          expect(subject.name_k).to eq('ミズホ')
          expect(subject.name_h).to eq('みずほ')
          expect(subject.name_e).to eq('mizuho')
        }
      end

      context 'when a bank does not exist' do
        let(:code) { '0000' }
        it { is_expected.to be_nil }
      end
    end

    describe '#search' do
      subject { described_class.search(query: query, limit: limit) }
      let(:limit) { 10 }
      context 'with query' do
        let(:query) { '三井住友' }
        it { is_expected.to be_a_kind_of(Array) }
        it 'contains query' do
          expect(subject.size).to eq(2)
          expect(subject.first.name).to eq('三井住友')
          expect(subject.last.name).to eq('三井住友信託')
        end

        context 'with limit option' do
          let(:limit) { 1 }
          it 'returns array with 1 item' do
            expect(subject.size).to eq(1)
            expect(subject.first.name).to eq('三井住友')
          end
        end
      end

      context 'without query' do
        let(:query) { '' }
        it { is_expected.to be_a_kind_of(Array) }
        it 'contains 10 results' do
          expect(subject.size).to eq(10)
          expect(subject.first).to be_a_kind_of(JpBank::Bank)
        end
      end
    end
  end

  describe 'attributes' do
    context 'valid bank' do
      let(:bank) { JpBank::Bank.find('0009') }
      it { expect(bank.code).to eq('0009') }
      it { expect(bank.name).to eq('三井住友') }
      it { expect(bank.name_h).to eq('みついすみとも') }
      it { expect(bank.name_k).to eq('ミツイスミトモ') }
      it { expect(bank.name_e).to eq('mitsuisumitomo') }
    end
  end

  describe '#branch_search' do
    let(:bank) { JpBank::Bank.find('0009') }
    subject { bank.branches }
    context 'with query' do
      it { is_expected.to be_a_kind_of(JpBank::BranchMap)}
    end
  end

  describe '#to_h' do
    let(:bank) { JpBank::Bank.find('0009') }
    subject { bank.to_h }
    it { is_expected.to eq({
        code: bank.code,
        name: bank.name,
        name_h: bank.name_h,
        name_k: bank.name_k,
        name_e: bank.name_e
      })
    }
  end

  describe '#to_json' do
    let(:bank) { JpBank::Bank.find('0009') }
    it { expect(bank.to_json).to eql({
        code: bank.code,
        name: bank.name,
        name_h: bank.name_h,
        name_k: bank.name_k,
        name_e: bank.name_e
      }.to_json)
    }
  end
end
