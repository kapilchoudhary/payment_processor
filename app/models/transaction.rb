class Transaction < ApplicationRecord
  belongs_to :merchant, class_name: 'Merchant'
  enum status: %i[approved reversed refunded error]

  validates_presence_of :customer_email, :customer_phone
  scope :last_one_hours, -> { where(created_at < 1.hours.ago)}

  after_initialize :set_uuid

  def authorized?
    type == 'AuthorizeTransaction'
  end

  def charged?
    type == 'ChargeTransaction'
  end

  def refunded?
    type == 'RefundTransaction'
  end

  def reversed?
    type == 'ReversalTransaction'
  end

  private

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end