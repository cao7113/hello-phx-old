defmodule HelloWeb.Api.PostView do
  use HelloWeb, :view
  alias HelloWeb.Api.PostView

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    %{id: post.id}
  end
end
