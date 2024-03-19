

import 'package:audioplayers/audioplayers.dart';

final player = AudioPlayer();

Future<void> playAudio(String sound) async {
  await player.play(UrlSource(sound));
  player.dispose();
}