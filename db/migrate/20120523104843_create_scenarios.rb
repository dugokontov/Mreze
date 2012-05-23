class CreateScenarios < ActiveRecord::Migration
  def change
    create_table :scenarios do |t|
      t.string :title
      t.string :scenario_type

      t.timestamps
    end
  end
end
