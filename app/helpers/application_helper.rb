module ApplicationHelper

  def email_link(users, recurrence = nil)
    if users.count != nil
        mail_to(users.map(&:email).join(", "), name = "", html_options = {
          class: "icon-envelope",
          title: "eMail an Spieler dieser Gruppe versenden!",
          subject: "#{recurrence.event.category} am #{recurrence.scheduled_to.strftime("%e. %B %Y")}",
          body: "Hey,\nwir brauchen mehr Leute ..."
          })
    end
  end

end

