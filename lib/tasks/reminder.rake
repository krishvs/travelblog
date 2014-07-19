namespace :reminder do
	desc "Calculate costs for failed freshfone calls in the last 4 hours"
	task :email => :environment do
		Reminder.all.each do |reminder|
			if reminder.sent == 0
				ReminderMailer.reminder_email(reminder).deliver
			end
		end
	end
end
