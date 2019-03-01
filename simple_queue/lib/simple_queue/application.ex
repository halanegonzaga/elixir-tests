defmodule SimpleQueue.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: SimpleQueue.Worker.start_link(arg)
      # {SimpleQueue.Worker, arg}
      #SimpleQueue  -> lista com nome
      #{SimpleQueue, [1,2,3]} -> lista com tuplas
      {SimpleQueue, [1,2,3]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options

    @doc """
      Tipos de Estratégias: 
      
      :one_for_one - Apenas reinicia os processos filhos que falharem.

      :one_for_all - Reinicia todos os processos filhos no evento da falha.

      :rest_for_one - Reinicia o processo que falhou e qualquer processo que começou depois deste.
    """
    opts = [strategy: :one_for_one, name: SimpleQueue.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
