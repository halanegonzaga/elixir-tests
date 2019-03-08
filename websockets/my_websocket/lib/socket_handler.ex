defmodule MyWebsocket.SocketHandler do
    @behaviour :cowboy_websocket

    @doc """
        Inicialização - conexão aberta com cliente (onOpen)

        Opções:
        - compress: {true/false} Se habilitar a extensão de compactação de quadro Websocket. Os quadros só serão compactados para os clientes que suportam essa extensão.
        - idle_timeout: {milessegundos} Tempo em milissegundos que o Cowboy manterá a conexão aberta sem receber nada do cliente.
    """
    def init(request, _) do
        IO.inspect "Conexão com cliente aberta"
        # IO.inspect request

        state = %{registry_key: request.path}
        opts = %{compress: true, idle_timeout: 60000} # 60000mss = 1min - Padrão
        
        {:cowboy_websocket, request, state, opts}
    end

    @doc """
        Registrar estado da conexão e retornar um OK para o socket realizar o Handshake
    """
    def websocket_init(state) do

        Registry.MyWebsocket
        |> Registry.register(state.registry_key, {})


        {:ok, state}
    end

    def websocket_handle({:binary, message}, state) do
        IO.inspect "Mensagem em binário: " <> message

        # payload = Jason.decode!(message);
        # message = payload["message"];

        Registry.MyWebsocket
        |> Registry.dispatch(state.registry_key, fn(sessions) ->
            for {pid, _} <- sessions do
                if(pid != self()) do
                    Process.send(pid, {:binary, message}, [])
                end
            end
        end)

        {:reply, {:text, "ms,#{:os.system_time}"}, state}
    end

    @doc """
        Manipulando ping da página
    """
    def websocket_handle({:text, "??tm"}, state) do
        {:reply, {:text, "!#{:os.system_time}"}, state}
    end
    
    @doc """
        Manipulando texto recebido do cliente (JSON)
    """
    def websocket_handle({:text, json}, state) do
        IO.inspect "Mensagem de Texto: " <> json
        {:reply, {:text, "tx,#{:os.system_time}"}, state}
    end

    @doc """
        Manipulando ping recebido do cliente
    """
    def websocket_handle({:ping, message}, state) do
        IO.puts "Ping recebido: " <> message

        {:reply, {:pong, message}, state}
    end

    @doc """
        Formatar e encaminhar mensagem para cliente
    """
    def websocket_info(info, state) do
        IO.inspect "Encaminhando mensagem para sessão" 

        {:reply, info, state}
    end

    @doc """
        Manipulando fechamento da conexão (onClose)
    """
    def terminate(_reason, _req, _state) do
       IO.inspect "Conexão Fechada"
    #    IO.inspect reason
    #    IO.inspect req
    #    IO.inspect state 
        :ok
    end
    
end