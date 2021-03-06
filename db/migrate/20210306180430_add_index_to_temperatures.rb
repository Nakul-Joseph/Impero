class AddIndexToTemperatures < ActiveRecord::Migration[6.1]
  def change
    add_index :temperatures, :temp_type
  end
end
