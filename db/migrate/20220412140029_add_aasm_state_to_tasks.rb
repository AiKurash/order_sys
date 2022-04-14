class AddAasmStateToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :aasm_state, :string, :default => 'inactive'
  end
end
