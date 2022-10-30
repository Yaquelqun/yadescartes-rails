class CreateUserTable < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :pseudo
      t.string :password_digest
      t.string :email

      t.timestamps
    end
  end
end

