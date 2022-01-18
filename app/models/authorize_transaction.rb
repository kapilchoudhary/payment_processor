class AuthorizeTransaction < Transaction
  has_many :charge_transactions, class_name: 'ChargeTransaction', foreign_key: 'reference_id'

  has_many :reversal_transactions, class_name: 'ReversalTransaction', foreign_key: 'reference_id'

  validates :amount, numericality: { greater_than: 0 }
end