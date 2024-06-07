import java.util.concurrent.Executors;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.ScheduledExecutorService;
import java.util.TimerTask;
import java.util.Timer;
import java.util.concurrent.TimeUnit;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Collections;
import java.io.Serializable;
import java.io.InputStream;
import java.util.Arrays;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.security.MessageDigest;
import java.nio.charset.StandardCharsets;

public final int MAX_PLAYERS = 5;
public final int PORT = 54321;

void setup() {
  var fs = new FileSystemAccess();
  var loginServlet = new LoginServlet(fs);
  
  try( Server server = new Server(PORT, loginServlet) ) {
    server.start();
  } catch(Exception ex) {
    
  } 
}

void draw() {
  
}
