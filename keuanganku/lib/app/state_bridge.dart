class StateBridge {
  void Function()? update;
  StateBridge();
  init (void Function() updateState){
    update = updateState;
  }
}