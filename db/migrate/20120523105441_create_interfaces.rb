class CreateInterfaces < ActiveRecord::Migration
  def change
    create_table :interfaces do |t|
      t.integer :node_id
      t.string :ip_address
      t.string :protocol
      t.integer :connected_to_id

      t.timestamps
    end
  end
end
