namespace :delete do
  desc "transactions"
  task transactions: :environment do
    TransactionDeleteJob.perform_now
  end
end