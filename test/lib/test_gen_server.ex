defmodule TestGenServer do
    use GenServer

    @doc """
        Todo GenServer precisa ter o start_link
    """
    def start_link(state \\ []) do
        GenServer.start_link(__MODULE__, state, name: __MODULE__)
    end

    @doc """
        E um callback init/1
    """
    def init(state) do
        {:ok, state}
    end
end