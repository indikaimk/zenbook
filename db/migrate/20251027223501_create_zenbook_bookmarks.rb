class CreateZenbookBookmarks < ActiveRecord::Migration[8.1]
  def change
    create_table :zenbook_bookmarks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :page, null: false, foreign_key: true

      t.timestamps
    end
  end
end
