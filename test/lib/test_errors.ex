defmodule TestErros do
    
    @doc """
        Criando mensagem de erro
    """
    def create_error(msg) do
        raise msg
    end

    @doc """
        Criando mensagem de erro para um tipo
    """
    def create_other_error(msg) do
        raise ArgumentError, message: msg
    end

    @doc """
        Tratamento de erro
    """
    def try_rescue(msg) do
    
        try do
            #create_error msg
            create_other_error msg
        rescue 
            e in RuntimeError -> #catch
            IO.puts "Ocorreu um erro, a mensagem de erro é: " <> e.message

            e in ArgumentError -> #catch
            IO.puts "Ocorreu um erro de ArgumentError é: " <> e.message
        end
    end

    @doc """
        Tratamento de erro e ação após erro
    """
    def try_with_after(msg) do
        {:ok, file} = File.open("lib/test.txt")

        IO.puts "Abriu arquivo ? "
        IO.inspect :ok

        try do
            # Nothing
            create_error msg
        rescue
            e in RuntimeError -> IO.puts e.message
        after
            IO.puts "Fechou arquivo"
            File.close(file)
        end
    end

    @doc """
        Testando estrutura de exceção criada
    """
    def test_new_error do
        try do
            raise NewError
        rescue
            e in NewError -> e.message
        end
    end

    @doc """
        Testando tratativa de erro try/catch
    """
    def try_catch do
        try do
            for x <- 0..10 do
                if x == 5 do
                    throw(x)
                end
            end
        catch
            x -> "Erro em #{x}"
        end
    end
end