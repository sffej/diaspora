class Notifier < ActionMailer::Base
  helper :application

  default :from => AppConfig[:smtp_sender_address]

  ATTACHMENT = File.read("#{Rails.root}/public/images/white_on_grey.png")

  def self.admin(string, recipients, opts = {})
    mails = []
    recipients.each do |rec|
      mail = single_admin(string, rec)
      mails << mail
    end
    mails
  end

  def single_admin(string, recipient)
    @recipient = recipient
    @string = string.html_safe
    attachments.inline['diaspora_white_on_grey.png'] = ATTACHMENT
    mail(:to => @recipient.email,
         :subject => I18n.t('notifier.single_admin.subject'), :host => AppConfig[:pod_uri].host)
  end

  def new_request(recipient_id, sender_id)
    @receiver = User.find_by_id(recipient_id)
    @sender = Person.find_by_id(sender_id)

    log_mail(recipient_id, sender_id, 'new_request')

    attachments.inline['diaspora_white_on_grey.png'] = ATTACHMENT

    mail(:to => "\"#{@receiver.name}\" <#{@receiver.email}>",
         :subject => I18n.t('notifier.new_request.subject', :from => @sender.name), :host => AppConfig[:pod_uri].host)
  end

  def request_accepted(recipient_id, sender_id)
    @receiver = User.find_by_id(recipient_id)
    @sender = Person.find_by_id(sender_id)

    log_mail(recipient_id, sender_id, 'request_accepted')

    attachments.inline['diaspora_white_on_grey.png'] = ATTACHMENT

    mail(:to => "\"#{@receiver.name}\" <#{@receiver.email}>",
          :subject => I18n.t('notifier.request_accepted.subject', :name => @sender.name), :host => AppConfig[:pod_uri].host)
  end

  def comment_on_post(recipient_id, sender_id, comment_id)
    @receiver = User.find_by_id(recipient_id)
    @sender   = Person.find_by_id(sender_id)
    @comment  = Comment.find_by_id(comment_id) 

    log_mail(recipient_id, sender_id, 'comment_on_post')

    attachments.inline['diaspora_white_on_grey.png'] = ATTACHMENT

    mail(:to => "\"#{@receiver.name}\" <#{@receiver.email}>",
          :subject => I18n.t('notifier.comment_on_post.subject', :name => @sender.name), :host => AppConfig[:pod_uri].host)
  end

  def also_commented(recipient_id, sender_id, comment_id)
    @receiver = User.find_by_id(recipient_id)
    @sender   = Person.find_by_id(sender_id)
    @comment  = Comment.find_by_id(comment_id) 
    @post_author_name = @comment.post.person.name
 

    log_mail(recipient_id, sender_id, 'comment_on_post')

    attachments.inline['diaspora_white_on_grey.png'] = ATTACHMENT

    mail(:to => "\"#{@receiver.name}\" <#{@receiver.email}>",
          :subject => I18n.t('notifier.also_commented.subject', :name => @sender.name, :post_author => @post_author_name ), :host => AppConfig[:pod_uri].host)
  end

  private
  def log_mail recipient_id, sender_id, type
    log_string = "event=mail mail_type=#{type} recipient_id=#{recipient_id} sender_id=#{sender_id}"
    if @receiver && @sender
      log_string << "models_found=true sender_handle=#{@sender.diaspora_handle} recipient_handle=#{@receiver.diaspora_handle}"
    else
      log_string << "models_found=false"
    end
    Rails.logger.info log_string
  end
end
