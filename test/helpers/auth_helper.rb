module AuthHelper
  def sign_in(user, password = "secret")
    # using password as a field instead of delegating it to fixtures, so fixtures can be loadable in the db for seeding
    post sessions_path, params: { user: { email: user.email, password: password } }
  end
end
