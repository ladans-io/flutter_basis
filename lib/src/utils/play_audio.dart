import 'package:audioplayers/audioplayers.dart';

Future<void> playAudio(String sound) async {
  final player = AudioPlayer();
  
  await player.setVolume(1);
  await player.setSourceAsset(sound);
  await player.resume();
}