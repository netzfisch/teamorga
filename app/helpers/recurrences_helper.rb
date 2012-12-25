module RecurrencesHelper
  def participation_link(recurrence, overrule = nil)

    if current_user.responded?(recurrence)

      if current_user.responded_at(recurrence).status == true
        button_to "doch noch Absagen", update_status_participation_path(current_user.responded_at(recurrence))
      elsif current_user.responded_at(recurrence).status == false
        button_to "doch noch Zusagen", update_status_participation_path(current_user.responded_at(recurrence))
        #change_user_recurrence_path(recurrence)
      end

    elsif overrule == 'accept'
      button_to "Zusagen", create_status_participation_path(recurrence, status: true)
      #add_user_recurrence_path(recurrence, status: true)

    elsif overrule == 'refuse'
      button_to "Absagen", create_status_participation_path(recurrence, status: false)
      #add_user_recurrence_path(recurrence, status: false)

    end
  end
end

