defmodule PhoenixCmsWeb.UserController do
  use PhoenixCmsWeb, :controller

  alias PhoenixCms.Accounts
  alias PhoenixCms.Accounts.User

  action_fallback PhoenixCmsWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, params) do
    with {:ok, %User{} = user} <- Accounts.create_user(%{"name" => params["name"], "email" => params["email"], "password" => params["password"]}) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, params) do
    user = Accounts.get_user!(params["id"])

    with {:ok, %User{} = user} <- Accounts.update_user(user, %{"name" => params["name"], "email" => params["email"], "password" => params["password"]}) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
