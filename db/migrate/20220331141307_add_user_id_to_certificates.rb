class AddUserIdToCertificates < ActiveRecord::Migration[6.1]
  def change
    add_column :certificates, :user_id, :integer
  end
end
