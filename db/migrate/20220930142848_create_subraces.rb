class CreateSubraces < ActiveRecord::Migration[7.0]
  def change
    create_table :subraces do |t|
      t.belongs_to :race, null: false, foreign_key: true
      t.string :name
      t.string :index
      t.string :languages
      t.integer :strength
      t.integer :dexterity
      t.integer :constitution
      t.integer :intelligence
      t.integer :wisdom
      t.integer :charisma

      t.timestamps
    end
  end
end
