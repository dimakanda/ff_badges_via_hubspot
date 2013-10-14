namespace :ff_badges do

  desc "Check each user for new badges and earn if deservers."
  task :check_and_earn => :environment do
  	User.find_in_batches(batch_size: 100) do |group|
  		group.each do |user|
  			user.check_and_earn_all_badges!
  		end
  	end
  end

end