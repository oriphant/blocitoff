# Learn more: http://github.com/javan/whenever
# http://railscasts.com/episodes/164-cron-in-ruby?autoplay=true

every :day, :at => '12:00am' do
  rake "todo:delete_items"
end

every :reboot do
  rake "todo:delete_items"
end
