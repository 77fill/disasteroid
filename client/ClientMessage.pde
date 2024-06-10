
interface ClientMessage extends Serializable
{  
}


class LoginRequestMessage implements ClientMessage
{
  final String username;
  final String password;
  
  
  public LoginRequestMessage( String username, String password )
  {
    this.username = username;
    this.password = password;
  }
  
  
  @Override
  public String toString()
  {
    return "[LoginRequestMessage] username = " + username + ", password = " + password;
  }
}
