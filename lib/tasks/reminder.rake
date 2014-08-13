namespace :reminder do
	desc "Calculate costs for failed freshfone calls in the last 4 hours"
	task :email => :environment do
		Reminder.all.each do |reminder|
			@users = reminder.folder.trip.users
			@users.each do |user|
				if reminder.sent == 0
					ReminderMailer.reminder_email(reminder,user).deliver
				end
			end
		end
	end
end
