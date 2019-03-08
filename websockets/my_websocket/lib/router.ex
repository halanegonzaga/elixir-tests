defmodule MyWebsocket.Router do
    use Plug.Router
    require EEx

    plug Plug.Static,
        at: "/",
        from: :my_websocket
    
    plug :match

    plug Plug.Parsers,
        parsers: [:json],
        pass: ["application/json"],
        json_decoder: Jason

    plug :dispatch

    EEx.function_from_file(:defp, :index, "lib/view/index.html.eex", [:user])
    EEx.function_from_file(:defp, :not_found, "lib/view/404.html.eex", [])

    # Página Inicial
    get "/:user" do
        # logged = %{token: conn.path_params["user"]}
        # IO.inspect "Logado => " <> logged[:token]

        paramUser = conn.path_params["user"]
        send_resp(conn, 200, index(paramUser))
    end

    # Caso rota não encontrada, ir para página de erro
    match _ do
        send_resp(conn, 404, not_found())
    end
end