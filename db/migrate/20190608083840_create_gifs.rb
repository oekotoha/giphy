class CreateGifs < ActiveRecord::Migration[5.2]
  def change
    create_table :gifs do |t|
      t.string :original_site
      t.string :original_file
      t.string :id
      t.datetime :trend_time
      t.datetime :post_time
      t.timestamps null: false
    end
  end
end
