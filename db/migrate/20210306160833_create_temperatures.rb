# frozen_string_literal: true

class CreateTemperatures < ActiveRecord::Migration[6.1]
  def change
    create_table :temperatures do |t|
      t.integer :name
      t.float :value

      t.timestamps
    end
  end
end
