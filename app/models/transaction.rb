class Transaction < ActiveRecord::Base
	belongs_to :upload
	has_one :merchant

	validates :purchaser_name, :presence => true
  validates :item_description, :presence => true
  validates :item_price, :presence => true
  validates :item_count, :presence => true

end
