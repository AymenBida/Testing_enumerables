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

  describe '#my_all?' do
    let(:arrs) {[1, 2, 't']}
    context 'when given an array and a block containing a condition ' do
      it 'should return true if every element in the array meets the condition' do
        expect(arr.my_all? {|a| a.is_a?(String)}).to be true 
      end
      
      it 'should return false if one of the elements does not meet the condition' do
        expect(arrs.my_all? {|a| a.is_a?(Integer)}).to be false
      end
    end

    context 'when given no block' do
      let (:falsy_array) {[false, nil, false, nil]}
      it 'should return true if each element in the block is truthy' do
        expect(arr.my_all?).to be true
      end

      it 'should return false if each element in the block is falsy' do
        expect(falsy_array.my_all?).to be false
      end
    end

    context 'when given an argument without a block' do
      let (:same_array) {['a','a','a']}
      let (:diff_array) {['a','a','b']}
      it 'should return true if every element is equal to the argument' do
        expect(same_array.my_all?('a')).to be true
      end
    
      it 'should return false if one or more elements is not equal to the argument' do
        expect(diff_array.my_all?('a')).to be false
      end
    end

    context 'when given a class as an argument' do
      it 'should return true if every element is included in the class' do
        expect(arr.my_all?(String)).to  be true
      end

      it 'should return false if one or more elements is not included in the class' do
        expect(arrs.my_all?(String)).to  be false
      end
    end

    context 'when given a Regexp as an argument' do
      let (:reg_array) {[/d/,/g/]}
      let (:anti_reg) {[/d/,7]}
      it 'should return true if every element is included in the reqexp' do
        expect(reg_array.my_all?(Regexp)).to  be true
      end

      it 'should return false if one or more elements is not included in the regexp' do
        expect(anti_reg.my_all?(Regexp)).to  be false
      end
    end
  end
end
