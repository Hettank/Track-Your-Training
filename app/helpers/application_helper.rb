module ApplicationHelper
  
  # won't show navbar in login and signup
  def show_navbar?
    !controller_name.in?(%w(sessions registrations passwords omniauth unlocks confirmations))
  end

  def show_footer?
    !controller_name.in?(%w(sessions registrations courses passwords omniauth unlocks confirmations))
  end
end
