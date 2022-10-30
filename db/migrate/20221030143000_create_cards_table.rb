class CreateCardsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :cards, id: :uuid do |t|
      t.string :rank, null: false
      t.string :suit, null: false
      t.references :owner, polymorphic: true, type: :uuid, null: false
      t.references :player, type: :uuid

      t.timestamps
    end
  end
end
