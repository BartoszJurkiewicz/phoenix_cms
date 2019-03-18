defmodule PhoenixCmsWeb.SessionController do
  use PhoenixCmsWeb, :controller
  alias PhoenixCms.Auth

  def sign_in(conn, attrs) do
    case Auth.sign_in(%{"email" => attrs["email"], "password" => attrs["password"]}) do
      {:ok, user} ->
        token = Phoenix.Token.sign(conn, System.get_env("USER_SALT"), user.id)
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
    conn
      |> clear_session
      |> put_status(200)
      |> json(%{data: "ok"})
  end
end