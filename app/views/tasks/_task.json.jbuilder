json.extract! task, :id, :title, :aasm_state, :created_at, :updated_at
json.url task_url(task, format: :json)
