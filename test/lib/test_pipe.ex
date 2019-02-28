defmodule TestPipe do
    
    @doc """
        Converte o texto em lista

        ## Exemplo
            iex> TestPipe.tokenize_string("É hora do show")
            ["É", "hora", "do", "show"]
    """
    def tokenize_string(string) do
        string
        |> String.split
    end

    @doc """
        Conveter texto em lista e deixar todas palavras maiúsculas

        ## Exemplo
            iex> TestPipe.uper_str("É hora do show")       
            ["É", "HORA", "DO", "SHOW"]
    """
    def uper_str(string) do
        string
        |> String.upcase
        |> String.split
    end

    @doc """
        Checa terminação das palavras

        ## Exemplo
            iex> TestPipe.check_end("Teste","este") 
            true
    """
    def check_end(string, cond1) do
        string
        |> String.ends_with?(cond1)
    end
end