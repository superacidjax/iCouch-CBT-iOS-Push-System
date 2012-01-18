class Notifier < ActionMailer::Base
  default from: "icouch CBT <icouchcbt@gmail.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.record_submit.subject
  #
  def record_submit(content)
    @greeting = content

    mail to: "superacidjax@me.com", :subject => 'New Submit Arrived'
  end
end
