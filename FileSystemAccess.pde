final String URI_LOGIN_TABLE = "/server/data/logins.txt";

class FileSystemAccess {
  private Gson gson = new GsonBuilder().setPrettyPrinting().create();
  
  public LoginTable getLoginTable() {
    return gson.fromJson( 
      getStringByUri( URI_LOGIN_TABLE ),
      LoginTable.class);
  }
  
  public void setLoginTable(LoginTable loginTable) {
    saveStrings(
      URI_LOGIN_TABLE, 
      new String[] { gson.toJson(loginTable) });
  }
  
  private String getStringByUri( String uri ) {
    return String.join( "", loadStrings(uri) );
  }
}
