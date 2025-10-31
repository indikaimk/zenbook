class CreateZenbookBooks < ActiveRecord::Migration[8.1]
  def change
    create_table :zenbook_books do |t|
      t.integer :state, default: 0
      t.string :title
      t.text :description
      
      t.timestamps
    end
  end
end
