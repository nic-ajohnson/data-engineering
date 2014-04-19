require 'spec_helper'

describe Upload do
  describe 'Line Parsing' do
    before(:each) do
      @line = "Snake Plissken	$10 off $20 of food	10.0	2	987 Fake St	Bob's Pizza"
    end

    it 'should return a value for the line' do
      return_val = Upload.parse_line(@line, 1)
      expect(return_val).to eq(20.0)
    end

    it 'should create a merchant if it does not exist' do
      expect(Merchant.count).to eq(0)
      return_val = Upload.parse_line(@line, 1)
      expect(Merchant.count).to eq(1)
    end

    it 'should not create a merchant if it already exists' do
      Merchant.create(:name => "Bob's Pizza", :address => "987 Fake St")
      expect(Merchant.count).to eq(1)
      return_val = Upload.parse_line(@line, 1)
      expect(Merchant.count).to eq(1)
    end

    it 'should create a transaction record' do
      expect(Transaction.count).to eq(0)
      return_val = Upload.parse_line(@line, 1)
      expect(Transaction.count).to eq(1)
      transaction = Transaction.first
      expect(transaction.purchaser_name).to eq("Snake Plissken")
      expect(transaction.item_description).to eq("$10 off $20 of food")
      expect(transaction.item_price).to eq(10.0)
      expect(transaction.item_count).to eq(2)
      expect(transaction.merchant_id).to_not be_nil
      expect(transaction.upload_id).to_not be_nil
    end
  end

  describe 'File Parsing' do
    before(:each) do
      @file = ActionDispatch::Http::UploadedFile.new(
        :tempfile => File.new("#{Rails.root}/lib/assets/example_input.tab"),
        :file_name => "example_input.tab"
      )
    end

    it 'should create an upload' do
      expect(Upload.count).to eq(0)
      Upload.import(@file)
      expect(Upload.count).to eq(1)
    end

    it 'should create the correct number of transactions' do
      expect(Transaction.count).to eq(0)
      Upload.import(@file)
      expect(Transaction.count).to eq(4)
    end

    it 'should create the right number of merchants' do
      expect(Merchant.count).to eq(0)
      Upload.import(@file)
      expect(Merchant.count).to eq(3)
    end
    it 'should get correct gross value' do
      Upload.import(@file)
      expect(Upload.last.gross_revenue).to eq(95.0)
    end
  end
end
