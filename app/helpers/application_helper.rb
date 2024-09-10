module ApplicationHelper
  
  # won't show navbar in login and signup
  def show_navbar?
    !controller_name.in?(%w(sessions registrations))
  end

  def show_footer?
    !controller_name.in?(%w(sessions registrations courses))
  end
end
