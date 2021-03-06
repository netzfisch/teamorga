module ApplicationHelper

  def active_link_if(*controller, link_text, link_path)
    class_name = controller.include?(params[:controller]) ? "active" : nil

    content_tag(:li, class: class_name) do
      link_to link_text, link_path
    end
  end

  def markdown_parser(text)
    options = {
      filter_html: true,
      safe_links_only: true,
      autolink: true,
      hard_wrap: true
    }
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
    mention_link(markdown.render(text)).html_safe unless text.nil?
  end

  def mention_link(text)
    # before '@' matches: Start of string, White space, Not Word
    # after '@' matches: [a-z0-9_-], alternatively write \w for Word
    regex = /(^|\s|\W)@([a-z0-9_-]+)/i
    text.gsub(regex) {|x| "#{$1}<a href=\"/users/#{$2}\">@#{$2}</a>"}
  end

  def display_for(role)
    if role.to_s == "admin"
      yield if current_user.admin?
    elsif role.to_s == "owner"
      yield if current_user == @user || current_user.admin?
    end
  end

  def email_link(users, recurrence = nil)
    mail_to(users.map(&:email).join("; "), "", {
      class: "glyphicon glyphicon-envelope",
      title: "eMail an Spieler dieser Gruppe versenden!",
      body: "Hey,\nwir brauchen mehr ...",
      subject: "#{recurrence ? recurrence.event.category+' am '+recurrence.scheduled_to.strftime("%e. %B %Y") : 'Rundmail 2all'}"
      }
    ) unless users == []
  end
end
