class AddOrderId1ToCertificates < ActiveRecord::Migration[6.1]
  def change
    add_reference :certificates, :order, null: false, foreign_key: true
  end
end
