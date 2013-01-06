module ApplicationHelper

  def email_link(users, recurrence = nil)
    if users.count != nil
        mail_to(users.map(&:email).join(", "), name = "", html_options = {
          class: "icon-envelope",
          title: "eMail an Spieler dieser Gruppe versenden!",
          subject: "#{ unless recurrence == nil
                         recurrence.event.category
                       end }"+" am "+
                    "#{ unless recurrence == nil
                         recurrence.scheduled_to.strftime("%e. %B %Y")
                       end }",
          body: "Hey,\nwir brauchen mehr Bier/Leute ..."
          })
    end
  end

end

