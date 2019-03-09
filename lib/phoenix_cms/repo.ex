defmodule PhoenixCms.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_cms,
    adapter: Ecto.Adapters.Postgres
end
