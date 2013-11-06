module RecurrencesHelper
  def participation_link(recurrence, overrule = nil)

    if current_user.responded?(recurrence)

      if current_user.responded_at(recurrence).status == true
        button_to "doch noch Absagen", toggle_status_participation_path(current_user.responded_at(recurrence)), method: :put, :class => 'btn btn-danger btn-xs'
      elsif current_user.responded_at(recurrence).status == false
        button_to "doch noch Zusagen", toggle_status_participation_path(current_user.responded_at(recurrence)), method: :put, :class => 'btn btn-success btn-xs'
      end

    elsif overrule == 'accept'
      button_to "Zusagen", create_status_participation_path(recurrence, status: true), :class => 'btn btn-success btn-xs'

    elsif overrule == 'refuse'
      button_to "Absagen", create_status_participation_path(recurrence, status: false), :class => 'btn btn-danger btn-xs'

    end
  end
end
