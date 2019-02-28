defmodule User do
    defstruct name: nil, password: nil # nil em elixir equivale ao NULL no PHP

    @moduledoc """
        Criando estrutura de Usuário com as chaves

        * `name` - Nome do Usuário
        * `password` - Senha do Usuário

        ## Exemplo de Estrutura:
            iex> user = %User{name: "Halane", password: "123"}
            %User{name: "Halane", password: "123"}
            
            iex> user.name
            "Halane"
            
            iex> user.password
            "123"
    """
end