defmodule Hello.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :content, :string
      add :likes_count, :integer, default: 0

      timestamps()
    end

  end
end
