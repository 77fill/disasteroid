class Server implements AutoCloseable {
  private final int COUNT_MANAGING_THREADS = 1;
  private int port;
  private ScheduledExecutorService threadPool;
  private ServerSocket socket;
  private List<Socket> connectedSockets;
  private List<Servlet> servlets;
  
  public Server(int port, Servlet... servlets) throws IOException {
    this.port = port;
    this.threadPool = Executors.newScheduledThreadPool( 2*MAX_PLAYERS + COUNT_MANAGING_THREADS );
    socket = new ServerSocket(port);
    connectedSockets = Collections.synchronizedList(new ArrayList<>());
    this.servlets = Collections.synchronizedList( new ArrayList<>());
    this.servlets.addAll(Arrays.asList(servlets));
  }
  
  public void start() throws IOException {
    threadPool.execute( this::awaitNewClientConnection );
    maybeDeleteConnectedSockets();
  }
  
  public void awaitNewClientConnection() {
    try {
      while(true) {
        Socket socket = this.socket.accept();
        threadPool.execute( () -> listen(socket) );
        connectedSockets.add( socket );
      }
    } catch(IOException ex) {
      
    }
  }
  
  public void listen(Socket socket) {
    try {
      var instream = new ObjectInputStream( socket.getInputStream() );
      var outstream = new ObjectOutputStream( socket.getOutputStream() );
      
      while(true) {
        var message = (ClientMessage)instream.readObject();
        var responses = dispatch( message );
        for(var response : responses)
          outstream.writeObject(response);
      }
    } catch (Exception ex) {
      
    }
  }
  
  public List<ServerMessage> dispatch( ClientMessage message ) {
    List<ServerMessage> responses = new ArrayList<>();
    for(var servlet : servlets) 
      if(servlet.getRegisteredMessageTypes().contains(message.getClass()))
        responses.add( servlet.respondTo( message ) );
        
    return responses
              .stream()
              .filter( r -> !(r instanceof NoResponse) )
              .toList();
  }
  
  public void maybeDeleteConnectedSockets() {
    while(true) {
      List<Socket> toBeDeleted = new ArrayList<>();
      for(Socket socket : connectedSockets)
        if(socket.isClosed())
          toBeDeleted.add( socket );
          
      connectedSockets.removeAll( toBeDeleted );
      delay( 50 );
    }
  }
  
  @Override
  public void close() throws IOException {
    for(var socket : connectedSockets)
      socket.close();
      
    socket.close();
  }
}
