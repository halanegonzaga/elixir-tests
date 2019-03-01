defmodule ExPlug.HelloWorldPlug do
    import Plug.Conn

    @doc """
        função necessária para criação do plug
    """
    def init(options) do
        options
    end

    @doc """
        Função necessária para criação do plug
    """
    def call(conn, _opts) do
        conn
        |> put_resp_content_type("text/html")
        |> send_resp(200, "<h3>Olá Mundo</h3>")
    end
end