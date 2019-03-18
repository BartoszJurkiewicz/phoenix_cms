defmodule PhoenixCms.Auth do
  alias PhoenixCms.Repo
  alias PhoenixCms.Accounts

  def sign_in(%{"email" => email, "password" => password}) do
    user = Accounts.get_user_by_email!(email)

    case user do
      nil ->
        Argon2.dummy_checkpw()
        {:error, :invalid_credentials}
      
      user ->
        if Argon2.check_pass(user, password) do
          {:ok, user}
        else
          {:error, :invalid_credentials}
        end
    end
  end
end