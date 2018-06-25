require 'csv'

namespace :db do
  namespace :seed do
    desc "Seed merchants in database" 
    task :seed_merchants => :environment do
      CSV.foreach('./db/csv/merchants.csv', { headers: true, header_converters: :symbol } ) do |row|
        Merchant.find_or_create_by(row.to_h)
      end
    end

    desc "Seed items in database"
    task :seed_items => :environment do
      CSV.foreach('./db/csv/items.csv', { headers: true, header_converters: :symbol } ) do |row|
        Item.find_or_create_by(row.to_h)
      end
    end

    desc "Seed invoices in database"
    task :seed_invoices => :environment do
      CSV.foreach('./db/csv/invoices.csv', { headers: true, header_converters: :symbol } ) do |row|
        Invoice.find_or_create_by(row.to_h)
      end
    end

    desc "Seed invoice_items in database"
    task :seed_invoice_items => :environment do
      CSV.foreach('./db/csv/invoice_items.csv', { headers: true, header_converters: :symbol } ) do |row|
        InvoiceItem.find_or_create_by(row.to_h)
      end
    end

    desc "Seed customers in database"
    task :seed_customers => :environment do
      CSV.foreach('./db/csv/customers.csv', { headers: true, header_converters: :symbol } ) do |row|
        Customer.find_or_create_by(row.to_h)
      end
    end

    desc "Seed transactions in database"
    task :seed_transactions => :environment do
      CSV.foreach('./db/csv/transactions.csv', { headers: true, header_converters: :symbol } ) do |row|
        Transaction.find_or_create_by(row.to_h)
      end
    end
  end
end

desc "Seed all data"
task :seed_all_data => :environment do
  Rake::Task["db:seed:seed_merchants"].invoke
  Rake::Task["db:seed:seed_items"].invoke
  Rake::Task["db:seed:seed_invoice_items"].invoke
  Rake::Task["db:seed:seed_invoices"].invoke
  Rake::Task["db:seed:seed_transactions"].invoke
  Rake::Task["db:seed:seed_customers"].invoke
end