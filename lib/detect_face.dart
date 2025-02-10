import 'dart:js' as js;

Future<void> detectFaces(String videoElementId) async {
  final faces = js.context.callMethod('detectFaces', [videoElementId]);
  print('Detected faces: $faces');
}
