defmodule PhoenixCms.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset


  schema "posts" do
    field :content, :string
    field :title, :string
    belongs_to :user, PhoenixCms.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:content, :title])
    |> validate_required([:content, :title])
  end
end
