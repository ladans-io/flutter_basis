import 'package:audioplayers/audioplayers.dart';

Future<void> playAudio(String sound) async {
  final player = AudioPlayer();

  await player.setVolume(1);
  await player.setSourceAsset(sound);
  await player.resume();
}

Future<void> playAlert({String? errorPath, String? path}) async {
  if (errorPath == null && path == null) {
    throw('You need to specify the errorAudioPath & successAudioPath');
  } else {
    await playAudio(errorPath != null ? errorPath : path!);
  }
}