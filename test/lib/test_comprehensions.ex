defmodule TestComprehensions do
    
    @doc """
        Exemplo de uso de comprehensions com lista
    """
    def list(list) do
        for x <- list do # x <-  é chamada de generator
            x*x
        end
    end

    @doc """
        Exemplo de uso com listas
    """
    def keywords do
        for {_key, val} <- [one: 1, two: 2, three: 3], do: val
    end

    @doc """
        Exemplo de uso com map
    """
    def maps do
        for {k,v} <- %{"a" => "A", "b" => "B"} do
            {k,v}
        end
    end

    def test do
        #for x <- 1..10, x > 2, do: x # os números da lis acima de 2
        for x <- 1..10, is_number(x), do: x # verificar se são números
    end
end