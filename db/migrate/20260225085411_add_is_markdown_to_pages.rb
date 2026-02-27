class AddIsMarkdownToPages < ActiveRecord::Migration[8.1]
  def change
    add_column :zenbook_books, :is_markdown, :boolean, default: false
  end
end
