# Dart xxHash Binding
A Dart binding of [xxHash](https://github.com/Cyan4973/xxHash). <br>
Provides binding for both 128-bit and 64-bit versions of xxh3 hashing function.

## Usage
```dart
var xxh3 = Xxh3(); // Create instance of Xxh3

final data = utf8.encode("Holly"); // Convert string data to bytes

final hash64 = xxh3.digestTo64bit(data); // Use xxh3 64-bit version
final hash128 = xxh3.digestTo128bit(data); // Use xxh3 128-bit version

// Print hash bytes
print(hash64); 
print(hash128);
```