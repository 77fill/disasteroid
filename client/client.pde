import uibooster.UiBooster;
import java.util.regex.Pattern;
import java.net.Socket;

UiBooster booster = new UiBooster();
Server server = new Server();
Socket socket;
Dispatcher dispatcher;

void setup() {
  Socket socket = getSocket();
  dispatcher = new Dispatcher(socket);
  login();
  
}

void login() {
  while(true) {
    var credentials = booster.showLogin(
          "Login",
          "Zum Spiel",
          "Username",
          "Password",
          "Go",
          "Cancel");
          
    
  }
}

Socket getSocket() {  
  var serverForm = booster.createForm("Server Connection")
    .addText("IP").setID("ip")
    .addText("Port").setID("port")
    .setChangeListener((element,value,form)->{
      if(value instanceof String) {
        var val = (String) value;
        
        if(element.getId().equals("ip"))
          server.setIp(val);
        else if(element.getId().equals("port"))
          server.setPort(val);
      }
    });
    
  var connected = false;
  while(!connected) {
    serverForm.show();
    try {
      if(server.isValid()) {
        Socket socket = new Socket(server.getIp(),server.getPort());
        return socket; 
      }
    } catch(IOException ex) {
      booster.showErrorDialog("Verbindung konnte nicht hergestellt werden","ERROR");
    }
  }
  
  throw new IllegalStateException("Should have created a socket connection at this point.");
}

void draw() {
  
}
