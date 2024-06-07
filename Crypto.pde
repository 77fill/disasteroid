public byte[] getHash( String password ) {
  try {
    var digest = MessageDigest.getInstance("MD5");
    return digest.digest( password.getBytes(StandardCharsets.UTF_8) );
    
  } catch (Exception ex) {
    throw new IllegalArgumentException();
  }
}
