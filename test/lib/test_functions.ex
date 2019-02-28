defmodule TestFuncions do
    
    @doc """
        Teste de funções anonimas

        ##Exemplo
            iex> TestFuncions.test_sum(1,2)
            3
    """
    def test_sum(arg1, arg2) do
        sum = fn(a, b) -> a + b end
        sum.(arg1, arg2)
    end

    @doc """
        Funções nomeadas

        * hello/0
        * hello/1
        * hello/3
    """
    def hello, do: "Sem parametros"

    def hello(1), do: "1 parametro"

    def hello(1,2), do: "2 parametros"

    @doc """
        Funções privadas
        <> está concatenando o resultado e uma função + valor passado por parametro
    """
    def helloName(name), do: privateFunction() <> name

    defp privateFunction, do: "Olá, "

    @doc """
        Função com guard, ao chamar função deve executar os passos caso o parametro informado seja uma lista
        Após acessar a lista, ele deve acessar a segunda função assign que irá concatenar a lista com a função privada
        
        ## Exemplo
            iex> TestFuncions.assign(["Halane", "João"])
            "Olá, Halane, João"
    """
    def assign(names) when is_list(names) do
        names
        |> Enum.join(", ")
        |> assign
    end

    def assign(name) when is_binary(name) do
        privateFunction() <> name
    end

    @doc """
        Definindo valor padrão de argumentos

        ##Exemplo
        iex> TestFuncions.defaultArg("Halane")
        "Halane gosta de programar em Elixir"

        iex> TestFuncions.defaultArg("Halane", "PHP")
        "Halane gosta de programar em PHP"
    """
    def defaultArg(name, code \\ "Elixir") do
        name <> " gosta de programar em " <> code
    end
end