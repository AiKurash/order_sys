class CreateCertificates < ActiveRecord::Migration[6.1]
  def change
    create_table :certificates do |t|
      t.integer :Hag
      t.text :comment

      t.timestamps
    end
  end
end
