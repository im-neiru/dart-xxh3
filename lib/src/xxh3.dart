import 'dart:ffi';

import 'package:dart_xxh/src/loader.dart';

typedef FnCreateState = Pointer<NativeType> Function();
typedef Xxh3State = Pointer<NativeType>;

class Xxh3 {
  final dylib = loadLibrary();
  late Xxh3State state;

  Xxh3() {
    final FnCreateState createState = dylib
        .lookup<NativeFunction<FnCreateState>>("create_state")
        .asFunction();

    state = createState();
  }
}
