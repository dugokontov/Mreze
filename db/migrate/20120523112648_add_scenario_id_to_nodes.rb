class AddScenarioIdToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :scenario_id, :integer

  end
end
