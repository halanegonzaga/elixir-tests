defmodule TestString do
    
    @doc """
        Converter string em binário
    """
    def to_bin(string) do
        string <> <<0>>
    end

    @doc """
        Calcular tamanho da string
    """
    def length(string) do
        string
        |> String.length
    end

    @doc """
        Substituir caracteres
    """
    def replace(string, a, b) do
        String.replace(string, a, b)
    end

    @doc """
        Duplicar string
    """
    def duplicate(string, total) do
        String.duplicate(string, total)
    end
end