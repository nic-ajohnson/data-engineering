class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
    	t.string 	:purchaser_name
    	t.string 	:item_description
    	t.decimal :item_price
    	t.integer :item_count
    	t.references :merchant
    	t.references :upload
      t.timestamps
    end

    add_index :transactions, :upload_id
    add_index :transactions, :merchant_id
  end
end
