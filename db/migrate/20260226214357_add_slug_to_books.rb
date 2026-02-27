class AddSlugToBooks < ActiveRecord::Migration[8.1]
  def change
    add_column :zenbook_books, :slug, :string
    add_index :zenbook_books, :slug, unique: true
    add_column :zenbook_books, :published_at, :datetime


    # 2. Backfill existing records
    # We use find_each to load them in batches so we don't blow up the server RAM
    Zenbook::Book.find_each do |book|
      book.update_column(:slug, book.title.parameterize) if book.title.present?
    end

    # 3. Now that every book has a slug, enforce the null constraint
    change_column_null :zenbook_books, :slug, false
  end
end
