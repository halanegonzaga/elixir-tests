/**
 * Instancia da Função
 * @param {*} token 
 */
function SocketClient(username){
    this.username = username;
    this.host = 'ws://localhost:5000/ws/chat'
    this.blob = true;
    this.debug = true;

    this.conn;
    this.connected = false;

    this.elm_chat = document.getElementById('chat-msg');
    this.elm_form = document.getElementById('form');
    this.elm_send = document.getElementById('message');

    this.timing_ping = null;
    this.timing_reconnect = null;

    this.listeners();
}

/**
 * Debug do Sistema
 */
SocketClient.prototype.log = function(msg){
    var self = this;
    if(self.debug){
        if(typeof msg === 'string'){
            console.log('===> ' + msg);
        } else {
            console.log(msg);
        }
    }
}

/**
 * Iniciar conexão com socket e manipulador de eventos do mesmo
 */
SocketClient.prototype.init = function(){
    var self = this;

    self.log('Solicitando conexão com HOST => ' + this.host);
    if(!self.connected){
        self.conn = new WebSocket(self.host + '?u=' + self.username);
        if(self.blob){
            self.conn.binaryType = 'blob'
        } 
        self.conn.onopen = function(){
            self.log('Conexão com websocket está aberta');
            self.connected = true;
            self.ping();
        };
        self.conn.onclose = function(){
            self.log('Conexão com websocket foi fechada');
            self.connected = false;
            self.reconnect();
        };
        self.conn.onmessage = function(ev){
            self.process_message(ev.data);
        };
    }
}

/**
 * Tentativa de re-conexão após 10s
 */
SocketClient.prototype.reconnect = function(){
    var self = this;
    clearTimeout(self.timing_reconnect);

    if(!self.connected){
        self.log('Aguardando 10s para reconectar');
        self.timing_reconnect = setTimeout(function(){
            self.init();
        }, 10000); //10s
    }
}

/**
 * Manipular elementos no DOM
 */
SocketClient.prototype.listeners = function(){
    var self = this;
    self.elm_form.addEventListener("submit", function(ev){
        self.send_form(ev, self);
    });
}

/**
 * Enviar PING
 */
SocketClient.prototype.ping = function(){
    var self = this;
    clearTimeout(self.timing_ping);

    if(self.connected){
        self.log('Enviando ping');
        self.send_text("??tm");

        self.timing_ping = setTimeout(function(){
            self.ping();
        }, 30000); //30s
    }
}

/**
 * Enviar Texto 
 */
SocketClient.prototype.send_text = function(text){
    var self = this;
    if(self.connected){
        self.conn.send(text);
    }
}

/**
 * Enviar Texto em Binário
 */
SocketClient.prototype.send_blob = function(message){
    var self = this;
    if(self.connected){
        var json = {message: message, user: self.username}
        var blob = new Blob([JSON.stringify(json, null, 2)], {type : 'application/json'});
        self.conn.send(blob);
    }
}

/**
 * Adicionar elemento na página
 */
SocketClient.prototype.add_to_chat = function(by, username, message, self){
    message = username + ": " + message

    var newDiv = document.createElement('div');
    newDiv.innerHTML = message;
    newDiv.classList = "msg " + by;
    self.elm_chat.appendChild(newDiv);
}

/**
 * Manipular evento onsubmit
 */
SocketClient.prototype.send_form = function(evt, self){
    evt.preventDefault();
    var message = self.elm_send.value;

    self.log('Enviando mensagem do formulário: ' + message);
    
    self.elm_send.value = '';
    self.send_blob(message);
    self.add_to_chat("me", self.username, message, self);

    return false;
}

/**
 * Processar mensagem recebida
 */
SocketClient.prototype.process_message = function(data){
    var self = this;

    self.log('Nova mensagem recebida do socket');

    if(typeof data === 'string'){
        self.log('Texto: ');
        self.log(data);
    } else if(typeof data === 'object'){
        self.log('Binário: ');
        self.log(data);

        var received = new Response(data);
        var promise = received.text();
        promise.then(function(json){
            json = JSON.parse(json);

            if(json.user == self.username){
                self.add_to_chat("me", json.user, json.message, self);
            } else {
                self.add_to_chat("other", json.user, json.message, self);
            }
        });
    }
}