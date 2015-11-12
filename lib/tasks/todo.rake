namespace :todo do
  desc "Delete items older than seven days after expiration"
  task delete_items: :environment do
    Item.where("expiration <= ?", Time.now - 7.days).destroy_all
  end
end
