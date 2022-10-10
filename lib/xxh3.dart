import 'dart:ffi';

import 'package:dart_xxh/loader.dart';

typedef Xxh3State = Pointer<NativeType>;
typedef FnCreateState = Xxh3State Function();
typedef FnDestroyState = Void Function(Xxh3State);

class Xxh3 {
  final dylib = loadLibrary();
  late Xxh3State state;

  // ignore: unused_field
  static final Finalizer<Xxh3> _finalizer = Finalizer((xxh3) => xxh3.dispose());

  Xxh3() {
    final FnCreateState createState = dylib
        .lookup<NativeFunction<FnCreateState>>("create_state")
        .asFunction();

    state = createState();
  }

  void dispose() {
    final void Function(Xxh3State) destroyState = dylib
        .lookup<NativeFunction<FnDestroyState>>("destroy_state")
        .asFunction();

    destroyState(state);
  }
}
