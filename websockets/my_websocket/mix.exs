defmodule MyWebsocket.MixProject do
  use Mix.Project

  # Detalhes do Projeto
  def project do
    [
      app: :my_websocket,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Executar "mix help compile.app" 
  def application do
    [
      extra_applications: [:logger],
      mod: {MyWebsocket.Application, []}
    ]
  end

  # Executar "mix help deps" para dúvidas
  defp deps do
    [
      {:cowboy, "~> 2.6"},
      {:plug, "~> 1.7"},
      {:plug_cowboy, "~> 2.0"},
      {:jason, "~> 1.1"}
    ]
  end
end
