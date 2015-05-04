module NotificationMailers
  class ConfirmEmail < NotificationMailers::Base
    def set_headers
      @headers[:to] = name_and_address(@recipient.first_name, @recipient.unconfirmed_email)
      @headers[:subject] = I18n.t('notifier.confirm_email.subject')
    end
  end
end
