defmodule PhoenixCms.Auth do
  alias PhoenixCms.Accounts

  def sign_in(%{"email" => email, "password" => password}) do
    user = Accounts.get_user_by_email!(email)

    case user do
      nil ->
        Argon2.dummy_checkpw()
        {:error, :invalid_credentials}
      
      user ->
        Argon2.check_pass(user, password)
    end
  end
end