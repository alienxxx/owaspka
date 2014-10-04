class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.string :topic
      t.datetime :date
      t.text :agenda
      t.integer :volume

      t.timestamps
    end
  end
end
