class Order < ApplicationRecord
  belongs_to :user
  has_many :certificates

  def advance_status
    if self.order_status == 'inactive'
      self.order_status = 'requested'
    elsif self.order_status == 'requested'
      self.order_status = 'production'
    else self.order_status == 'production'
      self.order_status = 'complete'
    end
  end

# Cancel order only if the order is inactive, requested, production.
# Can there be a different way to write without the != operator?

  def cancel_order
    if self.order_status != 'complete'
      self.order_status = 'cancelled'
    else
        puts "You can not cancel, the order is already complete. Please call customer service"
    end
  end

  extend FriendlyId
  friendly_id :name, use: :slugged

  def complete?
    self.order_status == 'complete'
  end

end
