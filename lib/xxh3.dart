import 'dart:ffi';

import 'package:dart_xxh/loader.dart';

typedef Xxh3State = Pointer<NativeType>;
typedef FnCreateState = Xxh3State Function();
typedef FnDestroyState = Void Function(Xxh3State);

class Xxh3 {
  final _dylib = loadLibrary();
  late Xxh3State _state;

  // ignore: unused_field
  static final Finalizer<Xxh3> _finalizer =
      Finalizer((xxh3) => xxh3._dispose());

  Xxh3() {
    final FnCreateState createState = _dylib
        .lookup<NativeFunction<FnCreateState>>("create_state")
        .asFunction();

    _state = createState();
  }

  void _dispose() {
    final void Function(Xxh3State) destroyState = _dylib
        .lookup<NativeFunction<FnDestroyState>>("destroy_state")
        .asFunction();

    destroyState(_state);
  }
}
