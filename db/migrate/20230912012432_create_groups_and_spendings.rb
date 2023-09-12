# frozen_string_literal: true

class CreateGroupsAndSpendings < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :icon
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    create_table :spendings do |t|
      t.string :name
      t.decimal :amount
      t.references :author, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    create_table :groups_spendings, id: false do |t|
      t.belongs_to :group
      t.belongs_to :spending
    end
  end
end
