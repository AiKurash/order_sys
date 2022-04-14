class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :name
      t.text :description
      t.string :order_status, :default => 'inactive'
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
