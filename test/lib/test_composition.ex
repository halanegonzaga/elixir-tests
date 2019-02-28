defmodule TestAlias do
    @test "Teste"
    # Criando módulo e função sem parametro

    def function do
        "Hello World! Isso é um " <> @test
    end
end

defmodule TestWithAlias do

    # incluindo módulo no segundo

    alias TestAlias

    # Função atual irá retornar resultado da primeira função

    def hello do
        TestAlias.function
    end

    # Retornando informações de um módulo
    def test do
        TestAlias.module_info
    end

    # debugando valores
    def debug do
        IO.inspect TestAlias.function
    end
end