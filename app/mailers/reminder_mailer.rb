class ReminderMailer < ActionMailer::Base
  default from: "from@example.com"

  def reminder_email(reminder)
    @user = reminder.folder.trip.user
    @reminder = reminder
    @reminder.sent = 1;
    @reminder.save
    mail(to: @user.email, subject: 'Your trip reminder')
  end

end
