class CreatePoems < ActiveRecord::Migration
  def change
    create_table :poems do |t|
      t.text :lexicon
      t.text :poem
      t.string :search

      t.timestamps null: false
    end
  end
end
