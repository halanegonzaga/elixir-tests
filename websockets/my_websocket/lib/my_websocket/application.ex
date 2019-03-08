defmodule MyWebsocket.Application do
  use Application

  # Definindo processos filhos que o supervisor irá acompanhar
  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: MyWebsocket.Router,
        options: [
          dispatch: dispatch(),
          port: 5000
        ]
      ),
      Registry.child_spec(
        keys: :duplicate,
        name: Registry.MyWebsocket
      )
    ]

    # Iniciando Supervisor
    opts = [strategy: :one_for_one, name: MyWebsocket.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Padrão de correspondência nas solicitações HTTP
  defp dispatch do
    [
      {:_, [
        {"/ws/[...]", MyWebsocket.SocketHandler, []},
        {:_, Plug.Cowboy.Handler, {MyWebsocket.Router, []}}
      ]}
    ]
  end
end
