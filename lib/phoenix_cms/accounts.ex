defmodule PhoenixCms.Accounts do
  import Ecto.Query, warn: false
  alias PhoenixCms.Repo

  alias PhoenixCms.Accounts.User

  def list_users do
    Repo.all(User)
  end

  def get_user!(id) do
    User
      |> Repo.get!(id)
      |> Repo.preload(:posts)
  end

  def get_user_by_email!(email), do: Repo.get_by!(User, email: email)

  def create_user(attrs \\ %{}) do
    %User{}
      |> User.changeset(attrs)
      |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
      |> User.changeset(attrs)
      |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end
end
