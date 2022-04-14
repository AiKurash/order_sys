class Task < ApplicationRecord
  belongs_to :user

  include AASM

  aasm do
    state :inactive, initial: true
    state :requested
    state :production
    state :complete
    state :canceled

    event :request do
      transitions from: :inactive, to: :requested
    end

    event :approve do
      transitions from: :requested, to: :production
    end

    event :complete do
      transitions from: :production, to: :complete
    end

    # to cancel an order you can use this way or also the guard approach guard: :cancellable?
    # task.aasm_status != 'complete'
    event :cancel do
      transitions from: [:inactive, :requested, :production], to: :canceled
      error do
        puts 'Not eligable to cancel the task is already complete'
      end
    end
  end

    aasm do
      state :complete, initial: true
      state :invoiced
      state :paid

      event :invoice do
        transitions from: :complete, to: :invoiced
      end

      event :apply_payment do
        transitions from: :invoiced, to: :paid
      end

    end

    private

    def task_cancellable
      self.aasm_status != 'complete'
    end
  end
