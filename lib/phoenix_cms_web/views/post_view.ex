defmodule PhoenixCmsWeb.PostView do
  use PhoenixCmsWeb, :view
  alias PhoenixCmsWeb.PostView

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    %{id: post.id,
      content: post.content,
      title: post.title}
  end
end
