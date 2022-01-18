require 'csv'

namespace :import do
  desc 'Import admins from CSV'
  task admins: :environment do
    admins = []
    file = Rails.root.join('admins.csv')
    CSV.foreach(file, headers: true) do |row|
      admins << Admin.new(import_params(row))
    end
    Admin.import admins
  end

  desc 'Import merchants from CSV'
  task merchants: :environment do
    merchants = []
    file = Rails.root.join('merchants.csv')
    CSV.foreach(file, headers: true) do |row|
      merchants << Merchant.new(import_params(row))
    end
    Merchant.import(merchants)
  end

  def import_params(params)
    {
      name: params['Name'],
      email: params['Email'],
      description: params['Description'],
      status: params['Status'],
      password: "#{params['Email'].split('@')[0]}pass123",
      admin_id: Admin.first&.id
    }
  end
end