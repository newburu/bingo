class AddTokenToGames < ActiveRecord::Migration[8.1]
  def change
    add_column :games, :token, :string
    add_index :games, :token
  end
end
