class CreateZenbookPages < ActiveRecord::Migration[8.1]
  def change
    create_table :zenbook_pages do |t|
      t.string :title
      t.integer :state, default: 0
      t.datetime :published_at
      t.references :book, null: false #, foreign_key: true

      t.timestamps
    end
  end
end
