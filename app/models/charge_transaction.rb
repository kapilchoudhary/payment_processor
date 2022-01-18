class ChargeTransaction < Transaction
  belongs_to :authorize_transaction, class_name: 'AuthorizeTransaction', foreign_key: 'reference_id'

  has_many :refund_transactions, class_name: 'RefundTransaction', foreign_key: 'reference_id'

  validates_presence_of :amount, numericality: { greater_than: 0 }

  after_save :update_merchant_total_transaction

  private

  def update_merchant_total_transaction
    merchant.total_transaction_sum += amount
    merchant.save
  end
end