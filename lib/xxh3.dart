import 'dart:ffi';
import 'dart:typed_data';
import 'package:dart_xxh/loader.dart';
import 'package:ffi/ffi.dart';

typedef Xxh3State = Pointer<NativeType>;
typedef NativeBytes = Pointer<Uint8>;
typedef FnCreateState = Xxh3State Function();
typedef FnDestroyState = Void Function(Xxh3State);
typedef FnDigestSignature = Bool Function(
    Xxh3State, NativeBytes, IntPtr, NativeBytes);

typedef FnDigest = bool Function(Xxh3State, NativeBytes, int, NativeBytes);

class Xxh3 {
  final _dylib = loadLibrary();
  late Xxh3State _state;
  late FnDigest _digest64bits;
  late FnDigest _digest128bits;

  // ignore: unused_field
  static final Finalizer<Xxh3> _finalizer =
      Finalizer((xxh3) => xxh3._dispose());

  Xxh3() {
    final FnCreateState createState = _dylib
        .lookup<NativeFunction<FnCreateState>>("create_state")
        .asFunction();

    _digest64bits = _dylib
        .lookup<NativeFunction<FnDigestSignature>>("digest_64bits")
        .asFunction();

    _digest128bits = _dylib
        .lookup<NativeFunction<FnDigestSignature>>("digest_128bits")
        .asFunction();

    _state = createState();
  }

  List<int> digestTo128bit(List<int> bytes) {
    final data = _toNativeBytes(bytes);
    final buffer = malloc.allocate<Uint8>(16);

    if (_digest128bits(_state, data, bytes.length, buffer) == false) {
      throw Exception("XXH3 error");
    }

    final hash = _fromNativeBytes(buffer, 16);

    malloc.free(data);
    malloc.free(buffer);

    return hash;
  }

  List<int> digestTo64bit(List<int> bytes) {
    final data = _toNativeBytes(bytes);
    final buffer = malloc.allocate<Uint8>(8);

    if (_digest64bits(_state, data, bytes.length, buffer) == false) {
      throw Exception("XXH3 error");
    }

    final hash = _fromNativeBytes(buffer, 8);

    malloc.free(data);
    malloc.free(buffer);

    return hash;
  }

  NativeBytes _toNativeBytes(List<int> bytes) {
    final ptr = malloc.allocate<Uint8>(bytes.length, alignment: 1);

    for (var i = 0; i < bytes.length; i++) {
      ptr.elementAt(i).value = bytes[i];
    }

    return ptr;
  }

  List<int> _fromNativeBytes(NativeBytes ptr, int length) {
    final arr = Uint8List(length);

    for (int i = 0; i < length; i++) {
      arr[i] = ptr.elementAt(i).value;
    }

    return arr;
  }

  void _dispose() {
    final void Function(Xxh3State) destroyState = _dylib
        .lookup<NativeFunction<FnDestroyState>>("destroy_state")
        .asFunction();

    destroyState(_state);
  }
}
