class StateBridge {
  void Function()? _update;
  StateBridge();
  init (void Function() updateState){
    _update = updateState;
  }
  void update(){
    if (_update != null){
      _update!();
    } else {
      
    }
  }
}