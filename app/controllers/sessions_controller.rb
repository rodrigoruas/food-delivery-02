require_relative "../views/sessions_view"
require_relative "../models/employee"

class SessionsController

  def initialize(employee_repo)
    @employee_repo = employee_repo
    @view = SessionsView.new
  end


  def login
    username = @view.ask_for_username
    password = @view.ask_for_password
    employee = @employee_repo.find_by_username(username)
    if employee && employee.password == password
      return employee
    else
      @view.print_wrong_credentials
      login
    end
  end
end
