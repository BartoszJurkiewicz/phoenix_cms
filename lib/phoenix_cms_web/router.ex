defmodule PhoenixCmsWeb.Router do
  use PhoenixCmsWeb, :router

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

    resources "/users", UserController do
      resources "/posts", PostController
    end
  end
end
