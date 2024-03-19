import 'package:audioplayers/audioplayers.dart';

Future<void> playAudio(String sound) async {
  final player = AudioPlayer();
  await player.play(AssetSource(sound));
  await player.dispose();
}