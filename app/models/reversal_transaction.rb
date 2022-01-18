class ReversalTransaction < Transaction
  belongs_to :authorize_transaction, class_name: 'AuthorizeTransaction', foreign_key: 'reference_id'

  after_save :update_merchant_total_transaction

  private

  def update_merchant_total_transaction
    merchant.total_transaction_sum = 0.0
    merchant.save
  end
end