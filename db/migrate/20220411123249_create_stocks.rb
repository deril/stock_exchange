# frozen_string_literal: true

class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.string :name, null: false
      t.references :bearer, null: false, foreign_key: true

      t.timestamps
    end
    add_index :stocks, :name, unique: true
  end
end
