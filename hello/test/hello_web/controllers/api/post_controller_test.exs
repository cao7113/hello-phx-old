defmodule HelloWeb.Api.PostControllerTest do
  use HelloWeb.ConnCase

  alias Hello.Blog
  alias Hello.Blog.Post

  @create_attrs %{body: "test"}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:post) do
    {:ok, post} = Blog.create_post(@create_attrs)
    post
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all posts", %{conn: conn} do
      conn = get(conn, Routes.post_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create post" do
    test "renders post when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_post_path(conn, :create), post: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_post_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_post_path(conn, :create), post: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update post" do
    setup [:create_post]

    test "renders post when data is valid", %{conn: conn, post: %Post{id: id} = post} do
      conn = put(conn, Routes.api_post_path(conn, :update, post), post: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_post_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, post: post} do
      conn = put(conn, Routes.api_post_path(conn, :update, post), post: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete post" do
    setup [:create_post]

    test "deletes chosen post", %{conn: conn, post: post} do
      conn = delete(conn, Routes.api_post_path(conn, :delete, post))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_post_path(conn, :show, post))
      end
    end
  end

  defp create_post(_) do
    post = fixture(:post)
    %{post: post}
  end
end
