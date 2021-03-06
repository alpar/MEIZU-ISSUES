class PushNotification::JournalNotification < PushNotification
  def self.notify(journal, event_name = '')
    if event_name == "comment"
      users = journal.issue.should_notify_users - journal.mentioned_users
    else
      users = journal.issue.should_notify_users
    end    
    
    users.map do |user|
      unless user == User.current
        create(event_name: event_name, pusher: journal, author: journal.user, recipient: user)
      end
    end
  end

  def project
    pusher.issue.project
  end
end