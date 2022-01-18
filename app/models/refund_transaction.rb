class RefundTransaction < Transaction
  belongs_to :charge_transaction, class_name: 'ChargeTransaction', foreign_key: 'reference_id'

  after_save :update_merchant_total_transaction

  private

  def update_merchant_total_transaction
    merchant.total_transaction_sum -= amount
    merchant.save
  end
end