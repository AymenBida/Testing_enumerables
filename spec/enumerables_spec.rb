require_relative '../bin/enumerables.rb'

describe Enumerable do
  let(:arr) { %w[a b c] }
  let(:range) { (1..5) }
  let(:hash) { { a: '1', b: '2' } }

  describe '#my_each' do
    context 'when given an array as an argument with a block' do
      it 'should return the same array' do
        expect(arr.my_each { |a| a }).to eq(%w[a b c])
      end
    end

    context 'when given a range as an argument with a block' do
      it 'should return the same range' do
        expect(range.my_each { |a| a }).to eq(1..5)
      end
    end

    context 'when given a hash as an argument with a block' do
      it 'should return the same hash' do
        expect(hash.my_each { |a| a }).to eq({ a: '1', b: '2' })
      end
    end

    context 'when given no block' do
      it 'should return an enumerator' do
        expect(arr.my_each).to be_an(Enumerator)
      end
    end
  end

  describe '#my_each_with_index' do
    context 'when given an array as an argument with a block' do
      it 'should return the same array' do
        expect(arr.my_each_with_index { |a, b| a == b }).to eq(%w[a b c])
      end
    end

    context 'when given a range as an argument with a block' do
      it 'should return the same range' do
        expect(range.my_each_with_index { |a| a }).to eq(1..5)
      end
    end

    context 'when given a hash as an argument with a block' do
      it 'should return the same hash' do
        expect(hash.my_each_with_index { |a| a }).to eq({ a: '1', b: '2' })
      end
    end

    context 'when given no block' do
      it 'should return an enumerator' do
        expect(arr.my_each_with_index).to be_an(Enumerator)
      end
    end
  end

  describe '#my_select' do
    context 'when given an array as an argument with a block containing a condition' do
      it 'should return a new array with elements that meet the condition given' do
        expect(arr.my_select { |a| a == 'b' }).to eq(%w[b])
      end

      it 'should return an empty array when none of the elements meet the condition given' do
        expect(arr.my_select { |a| a == 'x' }).to eq([])
      end
    end

    context 'when given no block' do
      it 'should return an enumerator' do
        expect(arr.my_select).to be_an(Enumerator)
      end
    end
  end
end
