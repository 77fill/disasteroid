class Server {
  private String ip;
  private Integer port;
  private boolean valid = false;
  
  public void check() {
    if( Pattern.matches("\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}",ip) 
    && port != null)
      valid = true;
    else
      valid = false;
  }
  
  public void setIp(String ip) {
    this.ip = ip;
    check();
  }
  
  public void setPort(String portStr) {
    try {
      var port = Integer.valueOf(portStr);
      if(port >= 1 && port <= 65535)
        this.port = port;
        
      check();
      
    } catch(NumberFormatException ex) {
      
    }
    
  }
  
  public String getIp() {return ip;}
  public int getPort() {return port;}
  public boolean isValid() {return valid;}
}
