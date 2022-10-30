class CreatePilesTable < ActiveRecord::Migration[7.0]
  def change
    create_table :piles, id: :uuid do |t|
      t.references :lobby, type: :uuid, null: false
      t.timestamps
    end
  end
end
