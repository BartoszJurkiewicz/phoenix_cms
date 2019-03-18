defmodule PhoenixCms.Posts do

  import Ecto.Query, warn: false
  alias PhoenixCms.Repo

  alias PhoenixCms.Accounts
  alias PhoenixCms.Posts.Post

  def list_posts do
    Repo.all(Post)
  end

  def get_post!(id), do: Repo.get!(Post, id)

  def create_post(attrs \\ %{}) do
    attrs
      |> IO.inspect

    user = Accounts.get_user!(attrs["user_id"])

    user
      |> IO.inspect
    post_changeset = Ecto.build_assoc(user, :posts, title: attrs["title"], content: attrs["content"])

    # Repo.insert(post_changeset)

    # %Post{}
    #   |> Post.changeset(attrs)
    #   |> Repo.insert()
  end

  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end
end
