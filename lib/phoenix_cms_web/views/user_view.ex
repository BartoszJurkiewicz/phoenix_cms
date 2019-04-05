defmodule PhoenixCmsWeb.UserView do
  use PhoenixCmsWeb, :view
  alias PhoenixCmsWeb.UserView
  alias PhoenixCmsWeb.PostView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user_with_posts.json")}
  end

  def render("user_with_posts.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
      name: user.name,
      posts: render_many(user.posts, PostView, "post.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
      name: user.name}
  end
end
