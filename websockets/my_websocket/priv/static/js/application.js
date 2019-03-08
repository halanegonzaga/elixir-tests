var chat_msg = document.getElementById('chat-msg');
var form = document.getElementById('form');
var ws;

/**
 * Função para inserir mensagem no HTML
 * @param {*} by 
 * @param {*} msg 
 */
function addMessageChat(by, msg){

    if(by == "me")
        msg = "Eu: " + msg
    else
        msg = "Outra pessoa: " + msg

    var div = document.createElement('div');
    div.innerHTML = msg;
    div.classList = "msg " + by;

    chat_msg.appendChild(div);
}

/**
 * Enviar Mensagem
 * @param {*} evt 
 */
function sendMessage(evt){
    evt.preventDefault();

    var msg = document.getElementById('message');
    addMessageChat("me", msg.value);
    sendToSocket(msg.value);

    msg.value = '';

    return false;
}

/**
 * Enviar Texto para Socket
 */
function sendToSocket(msg){
    ws.send(JSON.stringify(
        {
            message: msg
        }
    ));
}

/**
 * Conexão com Socket
 */
function connectWebSocket(){
    console.log("Abrindo conexão com socket");
    ws = new WebSocket('ws://localhost:5000/ws/chat');
    ws.binaryType = 'blob';

    ws.onopen = function(){
        console.log("Conexão com socket foi aberta");

        // console.log("Enviando 'ping'");
        // ws.send('ping');

        // console.log('Enviando binário');

        var debug = {hello: "world"};
        var blob = new Blob([JSON.stringify(debug, null, 2)], {type : 'application/json'});
        
        // ws.send(blob);
    }

    ws.onmessage = function(event){
        console.log("Nova mensagem recebida");

        if(typeof event.data === 'string'){
            console.log('Texto: ');
            console.log(event.data);
        } else if(typeof event.data === 'object'){
            console.log('Binário: ');
            console.log(event.data);

            var received = new Response(event.data);
            var promise = received.text();
            promise.then(function(json){
                console.log(JSON.parse(json));
            });

    

        }
    
    }

    ws.onclose = function(){
        console.log("Conexão com socket está fechada");
        // connectWebSocket()
    }
}

/**
 * Eventos
 */
form.addEventListener("submit", sendMessage);
// connectWebSocket();