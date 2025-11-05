class AddPageNumberToPages < ActiveRecord::Migration[8.1]
  def change
    add_column :zenbook_pages, :page_number, :integer
  end
end
