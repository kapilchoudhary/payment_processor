class Merchant < User
  belongs_to :admin, class_name: 'Admin'
  has_many :transactions

  def authorize_transactions
    transactions.where(type: 'AuthorizeTransaction')
  end

  def charge_transactions
    transactions.where(type: 'ChargeTransaction')
  end

  def refund_transactions
    transactions.where(type: 'RefundTransaction')
  end

  def reversal_transactions
    transactions.where(type: 'ReversalTRansaction')
  end
end