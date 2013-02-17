module ApplicationHelper

  def active_class_if(url, link)
   current_page?(url) ? content_tag(:li, link, class: "active") : content_tag(:li, link)
#  TODO: better match "model path", so sub-pages would be also highlighted
#  root_url.match(/.*\/\/.*\/"#{url}".*/) ? content_tag(:li, link, class: "active") : content_tag(:li, link)
  end
  
  def display_for(role)
    if role.to_s == "admin"
      yield if current_user.admin?
    elsif role.to_s == "owner"
      yield if current_user == @user || current_user.admin?
    end
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

