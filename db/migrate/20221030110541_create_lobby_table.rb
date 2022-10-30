class CreateLobbyTable < ActiveRecord::Migration[7.0]
  def change
    create_table :lobbies, id: :uuid do |t|
      t.string :status
      t.timestamps
    end
  end
end
