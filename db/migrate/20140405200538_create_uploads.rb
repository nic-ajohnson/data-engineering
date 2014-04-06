class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
    	t.decimal 	:gross_revenue
    	t.string 		:file_name
      t.timestamps
    end
  end
end
