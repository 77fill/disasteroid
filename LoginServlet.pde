class LoginServlet implements Servlet {
  private FileSystemAccess fs;
  
  @Override
  public Set<Class> getRegisteredMessageTypes() {
    return Set.of(LoginRequestMessage.class);
  }
  
  @Override
  public ServerMessage respondTo(ClientMessage clientMessage) {
    var message = (LoginRequestMessage) clientMessage;
    var loginTable = fs.getLoginTable();
    
    if(loginTable.contains(message.username) 
      && loginTable.checkPassword(
            message.username, 
            getHash( message.password )))
      ;
    
    return new NoResponse();
  }
  
  public LoginServlet( FileSystemAccess fs ) {
    this.fs = fs;
  }
}
