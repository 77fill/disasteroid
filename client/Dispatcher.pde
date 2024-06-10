class Dispatcher {
  private Socket socket;
  private ObjectInputStream oinStream;
  private ObjectOutputStream ooutStream;
  public Dispatcher(Socket socket) {
    this.socket = socket;
    this.ooutStream = new ObjectOutputStream( socket.getOutputStream() );
    this.oinStream = new ObjectInputStream( socket.getInputStream() );
  }
  
  public ServerMessage dispatch(ClientMessage message) {
    ooutStream.writeObject(message);
    return oinStream.readObject();
  }
}
