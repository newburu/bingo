class CreateGames < ActiveRecord::Migration[8.1]
  def change
    create_table :games do |t|
      t.json :history

      t.timestamps
    end
  end
end
