# frozen_string_literal: true

class FixColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :temperatures, :name, :temp_type
  end
end
