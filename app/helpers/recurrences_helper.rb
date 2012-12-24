module RecurrencesHelper
  def participation_link(recurrence, overrule = nil)

    if current_user.responded?(recurrence)

      if current_user.responded_at(recurrence).status == true
        button_to "doch noch Absagen", change_user_recurrence_path(recurrence)
      elsif current_user.responded_at(recurrence).status == false
        button_to "doch noch Zusagen", change_user_recurrence_path(recurrence)
      end

    elsif overrule == 'accept'
      button_to "Zusagen", add_user_recurrence_path(recurrence, status: true)

    elsif overrule == 'refuse'
      button_to "Absagen", add_user_recurrence_path(recurrence, status: false)

    end
  end
end

