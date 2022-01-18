class Merchant < User
  belongs_to :admin, class_name: 'Admin', optional: true
  has_many :transactions, dependent: :destroy
end