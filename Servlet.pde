interface Servlet {
  public Set<Class> getRegisteredMessageTypes();
  public ServerMessage respondTo(ClientMessage message);
}
