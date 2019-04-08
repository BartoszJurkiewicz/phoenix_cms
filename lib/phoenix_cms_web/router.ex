defmodule PhoenixCmsWeb.Router do
  use PhoenixCmsWeb, :router

  alias PhoenixCms.Accounts

  defp is_logged_in(conn, params) do
    user_salt = System.get_env("USER_SALT")
    user_id = get_session(conn, "user_id")
    user = Accounts.get_user!(user_id)
    user_token = conn.req_cookies["token"]
    is_admin = user.is_admin

    is_user_valid = user_id && Phoenix.Token.verify(conn, user_salt, user_token, max_age: 86400)

    case is_user_valid do
      {:error, _} ->
        conn
        |> put_status(403)
        |> json(%{error: "You have to be logged in."})
        |> halt

      {:ok, user} ->
        conn
        |> assign(:is_admin, is_admin)
    end
  end

  defp is_admin(conn, _params) do
    is_admin = conn.assigns[:is_admin]

    case is_admin do
      false -> 
        conn
        |> put_status(403)
        |> json(%{error: "You are not authorized."})
        |> halt

      true ->
        conn
    end
  end

  pipeline :browser do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end
  
  pipeline :logged do
    plug :is_logged_in
  end
  
  pipeline :admin do
    plug :is_admin
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhoenixCmsWeb do
    pipe_through :api

    post "/login", SessionController, :sign_in
    post "/logout", SessionController, :sign_out
  end

  scope "/api", PhoenixCmsWeb do
    pipe_through :api

    resources "/users", UserController, only: [:index, :show]
    resources "/posts", PostController, only: [:index, :show]
  end

  scope "/admin", PhoenixCmsWeb do
    pipe_through [:browser, :logged, :admin]

    resources "/users", UserController, except: [:index, :show] do
      resources "/posts", PostController, except: [:index, :show]
    end
  end
end
