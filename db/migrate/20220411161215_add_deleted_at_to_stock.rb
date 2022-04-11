# frozen_string_literal: true

class AddDeletedAtToStock < ActiveRecord::Migration[7.0]
  def change
    add_column :stocks, :deleted_at, :datetime
    add_index :stocks, :deleted_at
  end
end
