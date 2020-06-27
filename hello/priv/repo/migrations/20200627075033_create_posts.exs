defmodule Hello.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :body, :string
      add :words_count, :integer

      timestamps()
    end

  end
end
