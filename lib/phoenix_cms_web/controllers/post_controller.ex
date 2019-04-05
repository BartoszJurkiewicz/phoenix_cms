defmodule PhoenixCmsWeb.PostController do
  use PhoenixCmsWeb, :controller

  alias PhoenixCms.Repo
  alias PhoenixCms.Accounts
  alias PhoenixCms.Accounts.User
  alias PhoenixCms.Posts
  alias PhoenixCms.Posts.Post

  action_fallback PhoenixCmsWeb.FallbackController

  def index(conn, _params) do
    posts = Posts.list_posts()
    render(conn, "index.json", posts: posts)
  end

  def create(conn, post_params) do
    user =
      User
        |> Repo.get(post_params["user_id"])

    post_changeset = Ecto.build_assoc(user, :posts, title: post_params["title"], content: post_params["content"])

    case Repo.insert(post_changeset) do
      {:ok, _post} ->
        conn
          |> text("OK!")
      {:error, _post} ->
        conn
          |> text("OK!")
    end

    # with {:ok, %Post{} = post} <- Posts.create_post(post_params) do
    #   conn
    #   |> put_status(:created)
    #   # |> put_resp_header("location", Routes.post_path(conn, :show, post))
    #   |> render("show.json", post: post)
    # end
  end

  def show(conn, %{"id" => id}) do
    post = Posts.get_post!(id)
    render(conn, "show.json", post: post)
  end

  # def update(conn, %{"id" => id, "post" => post_params}) do
  #   post = Posts.get_post!(id)

  #   with {:ok, %Post{} = post} <- Posts.update_post(post, post_params) do
  #     render(conn, "show.json", post: post)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   post = Posts.get_post!(id)

  #   with {:ok, %Post{}} <- Posts.delete_post(post) do
  #     send_resp(conn, :no_content, "")
  #   end
  # end
end
