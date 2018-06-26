require 'csv'

namespace :db do
  namespace :seed do
    desc "Seed merchants in database" 
    pbar = ProgressBar.create(:title => "Merchants", :total => (CSV.read('./db/csv/merchants.csv')).count, :format => "%a %b\u{15E7}%i %p%% %t", :progress_mark  => ' ', :remainder_mark => "\u{FF65}", :starting_at => 1)
    task :seed_merchants => :environment do
      CSV.foreach('./db/csv/merchants.csv', { headers: true, header_converters: :symbol } ) do |row|
        pbar.increment
        Merchant.find_or_create_by(row.to_h)
      end
    end
    desc "Seed customers in database"
    task :seed_customers => :environment do
      pbar = ProgressBar.create(:title => "Customers", :total => (CSV.read('./db/csv/customers.csv')).count, :format => "%a %b\u{15E7}%i %p%% %t", :progress_mark  => ' ', :remainder_mark => "\u{FF65}", :starting_at => 1)
      CSV.foreach('./db/csv/customers.csv', { headers: true, header_converters: :symbol } ) do |row|
        pbar.increment
        Customer.find_or_create_by(row.to_h)
      end
    end
    desc "Seed invoices in database"
    task :seed_invoices => :environment do
      pbar = ProgressBar.create(:title => "Invoices", :total => (CSV.read('./db/csv/invoices.csv')).count, :format => "%a %b\u{15E7}%i %p%% %t", :progress_mark  => ' ', :remainder_mark => "\u{FF65}", :starting_at => 1)
      CSV.foreach('./db/csv/invoices.csv', { headers: true, header_converters: :symbol } ) do |row|
        pbar.increment
        Invoice.find_or_create_by(row.to_h)
      end
    end
    desc "Seed transactions in database"
    task :seed_transactions => :environment do
      pbar = ProgressBar.create(:title => "Transactions", :total => (CSV.read('./db/csv/transactions.csv')).count, :format => "%a %b\u{15E7}%i %p%% %t", :progress_mark  => ' ', :remainder_mark => "\u{FF65}", :starting_at => 1)
      CSV.foreach('./db/csv/transactions.csv', { headers: true, header_converters: :symbol } ) do |row|
        pbar.increment
        Transaction.find_or_create_by(row.to_h)
      end
    end

    desc "Seed items in database"
    task :seed_items => :environment do
      pbar = ProgressBar.create(:title => "Items", :total => (CSV.read('./db/csv/items.csv')).count, :format => "%a %b\u{15E7}%i %p%% %t", :progress_mark  => ' ', :remainder_mark => "\u{FF65}", :starting_at => 1)
      CSV.foreach('./db/csv/items.csv', { headers: true, header_converters: :symbol } ) do |row|
        pbar.increment
        Item.find_or_create_by(row.to_h)
      end
    end


    desc "Seed invoice_items in database"
    task :seed_invoice_items => :environment do
      pbar = ProgressBar.create(:title => "Invoice Items", :total => (CSV.read('./db/csv/invoice_items.csv')).count, :format => "%a %b\u{15E7}%i %p%% %t", :progress_mark  => ' ', :remainder_mark => "\u{FF65}", :starting_at => 1)
      CSV.foreach('./db/csv/invoice_items.csv', { headers: true, header_converters: :symbol } ) do |row|
        pbar.increment
        InvoiceItem.find_or_create_by(row.to_h)
      end
    end


  end
end

desc "Seed all data"
task :seed_all_data => :environment do
  Rake::Task["db:seed:seed_merchants"].invoke
  Rake::Task["db:seed:seed_customers"].invoke
  Rake::Task["db:seed:seed_invoices"].invoke
  Rake::Task["db:seed:seed_transactions"].invoke
  Rake::Task["db:seed:seed_items"].invoke
  Rake::Task["db:seed:seed_invoice_items"].invoke
end