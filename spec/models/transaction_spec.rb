require 'spec_helper'

describe Transaction do
  describe 'validation' do
    it 'should validate correctly' do
      t = Transaction.new
      expect(t.valid?).to be_false
      t.purchaser_name = "Joe Schmoe"
      expect(t.valid?).to be_false
      t.item_description = "Test Item"
      expect(t.valid?).to be_false
      t.item_price = 5.0
      expect(t.valid?).to be_false
      t.item_count = 2
      expect(t.valid?).to be_false
      t.merchant_id = 1
      expect(t.valid?).to be_true
    end
  end
end
