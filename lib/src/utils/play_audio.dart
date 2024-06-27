import 'package:audioplayers/audioplayers.dart';

Future<void> playAudio(String sound) async {
  final player = AudioPlayer();

  await player.setVolume(1);
  await player.setSourceAsset(sound);
  await player.resume();
}

Future<void> playAlert({
  String? errorPath, 
  required String path, 
  bool error = false, 
  bool info = false,
}) async {
  if (error && errorPath != null) await playAudio(errorPath);
  await playAudio(path);
}