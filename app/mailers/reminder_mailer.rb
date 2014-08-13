class ReminderMailer < ActionMailer::Base
  default from: "from@example.com"

  def reminder_email(reminder,user)
    @reminder = reminder
    @reminder.sent = 1;
    @reminder.save
    @user = user
    puts "The value of the users is #{@user.inspect}"
	puts "The value of the user_meila is #{@user.email}"
	mail(to: user.email, subject: 'Your trip reminder', :locals => { :user => user})		
  end

end
