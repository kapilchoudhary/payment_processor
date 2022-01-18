class Transaction < ApplicationRecord
  belongs_to :merchant, class_name: 'Merchant'
  enum status: %i[approved reversed refunded error]

  validates_presence_of :customer_email, :customer_phone

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