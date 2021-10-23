class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :sender
      t.string :body
      t.string :room
    end
  end
end
