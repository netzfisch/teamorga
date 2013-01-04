module ApplicationHelper

  def email_link(users, recurrence = nil)
    if users.count != nil
      mail_to(users.map(&:email).join(", "), "email2all !", html_options = {
        subject: "#{recurrence.event.category} am #{recurrence.scheduled_to.strftime("%e. %B %Y")}",
        body: "Hey,\n
               wir brauchen mehr Leute ..."
        })
    end
  end

end

