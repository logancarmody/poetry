class AddSecondSearchToPoems < ActiveRecord::Migration
  def change
    add_column :poems, :second_search, :string
    add_column :poems, :ss, :boolean
  end
end
