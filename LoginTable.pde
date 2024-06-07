class LoginTable
{
  Map<String,byte[]> data;
  
  
  public LoginTable()
  {
    data = new HashMap<>();
  }
  
  
  boolean contains( String username )
  {
    return data.containsKey( username );
  }
  
  
  boolean checkPassword( String username, byte[] pwHash )
  {
    assert this.contains( username ) : "The requested username:"+username+" does not exist!";
    byte[] correctHash = data.get( username );
    return Arrays.equals( correctHash,  pwHash );
  }
  
  
  public void put( String s, byte[] b )
  {
    data.put( s, b );
  }
  
  
  public void printDetails()
  {
    data.forEach( ( k, v ) -> { print( k + Arrays.toString( v ) + "\n" ); } );
  }
}
