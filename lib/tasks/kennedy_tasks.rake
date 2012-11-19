namespace :kennedy do
  desc 'Bootstrap Kennedy with necessary instances'
  task setup: :environment do

    Kennedy::Category.create(name: 'Uncategorized', slug: 'uncategorized')

  end
end