defmodule PhoenixCms.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  import Comeonin.Argon2

  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    field :name, :string
    field :password, :string, virtual: true
    has_many :posts, PhoenixCms.Posts.Post

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
      |> cast(attrs, [:email, :name])
      |> validate_required([:name, :email])
      |> validate_format(:email, ~r/@/)
      |> cast(attrs, [:password], [])
      |> validate_length(:password, min: 4, max: 128)
      |> encrypt_password()
  end

  defp encrypt_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :encrypted_password, Argon2.hash_pwd_salt(password))
      _ ->
        changeset
    end
  end
 end
