defmodule ExPlug.Router do
    use Plug.Router

    plug(:match)
    plug(:dispatch)

    get "/" do
        conn
        |> put_resp_content_type("application/json;charset=UTF-8")
        |> send_resp(200, "{teste: \"teste\"}")
    end

    match _ do
        conn
        |> put_resp_content_type("text/html;charset=UTF-8")
        |> send_resp(404, "Não há essa página aqui kakaroto")
    end
end