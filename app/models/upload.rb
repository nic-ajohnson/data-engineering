class Upload < ActiveRecord::Base

	has_many :transactions

	def self.import(file)
		upload = Upload.create(:file_name => file.original_filename)
		gross_revenue = 0.0
		file = File.open(file.path).each_line.with_index do |line, index|
			if index != 0
				gross_revenue += Upload.parse_line(line.chomp, upload.id)
			end
		end
		upload.update(gross_revenue: gross_revenue)
	end

	def self.parse_line(line, upload_id)
		line_arr = line.split("\t")
		purchaser_name = line_arr[0]
		description = line_arr[1]
		price = line_arr[2]
		count = line_arr[3]
		merchant_addr = line_arr[4]
		merchant_name = line_arr[5]

		merchant = Merchant.where(:name => merchant_name, :address => merchant_addr).first_or_create
		Transaction.create(:purchaser_name => purchaser_name, :item_description => description, :item_price => price, :item_count => count, :merchant_id => merchant.id, :upload_id => upload_id)
		revenue = price.to_f * count.to_f
	end
end
