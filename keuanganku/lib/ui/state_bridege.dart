class StateBridge {
  late final void Function() update;
  bool _initialized = false;
  
  init(void Function() updateStateFunction){
    if (!_initialized){
      update = updateStateFunction;
      _initialized = true;
    }
  }
}