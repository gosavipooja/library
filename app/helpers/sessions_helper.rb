module SessionsHelper
  def is_superadmin(email)
    email == "admin@ncsu.edu"
  end
end
