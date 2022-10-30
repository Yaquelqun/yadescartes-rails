class CreateParticipationsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :participations, id: :uuid do |t|
      t.boolean :active, default: true
      t.references :lobby, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end
