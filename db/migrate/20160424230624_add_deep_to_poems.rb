class AddDeepToPoems < ActiveRecord::Migration
  def change
    add_column :poems, :deep, :boolean
  end
end
