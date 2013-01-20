module ApplicationHelper

  def active_class(url)
    "class = active" if current_page?(url) 
  end

  def display_for_admin(&block)
   content_tag(:div, class: "admin", &block) if current_user.admin?
  end

  def email_link(users, recurrence = nil)
    unless users == []
      mail_to(users.map(&:email).join(", "), name = "", html_options = {
        class: "icon-envelope",
        title: "eMail an Spieler dieser Gruppe versenden!",
        subject: "#{ recurrence ? recurrence.event.category+' am '+recurrence.scheduled_to.strftime("%e. %B %Y") : "Rundmail 2all" }",
        body: "Hey,\nwir brauchen mehr Bier/Leute ..."
        })
     end
  end

end

