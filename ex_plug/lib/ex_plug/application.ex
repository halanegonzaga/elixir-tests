defmodule ExPlug.Application do
  use Application
  require Logger

  def start(_type, _args) do
    
    children = [
      {
        Plug.Cowboy,
        scheme: :http,
        plug: ExPlug.Router,
        options: [port: 80]
      }
    ]

    Logger.info("Iniciando aplicação na porta 3001")

    opts = [strategy: :one_for_one, name: ExPlug.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
