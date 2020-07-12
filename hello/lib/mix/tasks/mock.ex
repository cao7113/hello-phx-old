defmodule Mix.Tasks.Mock do
  use Mix.Task

  @shortdoc "mock"

  def run(args) do
    Mix.shell().info("mock #{inspect(args)}")
  end
end
