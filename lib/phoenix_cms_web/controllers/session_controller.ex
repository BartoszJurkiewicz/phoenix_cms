defmodule PhoenixCmsWeb.SessionController do
  use PhoenixCmsWeb, :controller
  alias PhoenixCms.Auth

  def sign_in(conn, attrs) do
    case Auth.sign_in(%{"email" => attrs["email"], "password" => attrs["password"]}) do
      {:ok, user} ->
        user_salt = System.get_env("USER_SALT")
        
        token = Phoenix.Token.sign(conn, user_salt, user.id)
        conn
          |> fetch_session
          |> put_session(:user_id, user.id)
          |> put_session(:token, token)
          |> put_status(200)
          |> json(%{user_id: user.id, csrf: get_csrf_token(), token: token})

      {:error, error} ->
        conn
          |> json(%{data: error})
    end
  end

  def sign_out(conn, _params) do
    delete_csrf_token()

    conn
      |> fetch_session
      |> clear_session
      |> put_status(200)
      |> json(%{data: "ok"})
  end
end