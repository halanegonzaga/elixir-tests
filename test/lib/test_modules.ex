defmodule FistModule do
    @greatting "Acesse o nosso site"
    @url "https://sac.digital"

    @doc """
        ## Resultado
            iex> FistModule.show
            "Acesse o nosso site"
    """
    def show do
        @greatting
    end

    @doc """
        ## Resultado
            iex> FistModule.link
            "Acesse o nosso site => https://sac.digital"
    """
    def link do
        "#{@greatting} => #{@url}"
    end
end

defmodule FistModule.Second do
    
end