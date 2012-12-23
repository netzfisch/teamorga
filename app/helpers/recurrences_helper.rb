module RecurrencesHelper
  def participation_link(recurrence, overrule = nil)

    if current_user.responded?(recurrence)
      if current_user.responded_at(recurrence).status == true
        button_to "doch noch Absagen", update_user_recurrence_path(recurrence)
        #use participation.status.toggle
      elsif current_user.responded_at(recurrence).status == false
        button_to "doch noch Zusagen", update_user_recurrence_path(recurrence)
      end

    elsif overrule == 'accept'
      button_to "Zusagen", add_user_recurrence_path(recurrence)

    elsif overrule == 'refuse'
      button_to "Absagen", remove_user_recurrence_path(recurrence)

    end
  end
end

