defmodule Colors.PageController do
  use Colors.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
