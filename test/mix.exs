defmodule Test.MixProject do
  use Mix.Project

  def project do
    [
      app: :test, # nome da aplicação
      version: "0.1.0", #versão da aplicação
      elixir: "~> 1.8", # versão do elixir
      start_permanent: Mix.env() == :prod,
      deps: deps() # dependencias
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.19.3"}
    ]
  end
end
