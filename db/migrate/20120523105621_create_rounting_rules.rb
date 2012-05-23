class CreateRountingRules < ActiveRecord::Migration
  def change
    create_table :rounting_rules do |t|
      t.string :scenario_type
      t.string :node_type
      t.string :protocol_in
      t.string :protocol_out
      t.text :script

      t.timestamps
    end
  end
end
