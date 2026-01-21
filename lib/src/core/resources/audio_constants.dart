final class AudioConstants {
  static String audioSoundBoxDown = _AudioApp.audioSoundBoxDown.path;
  static String audioSoundBoxUp = _AudioApp.audioSoundBoxUp.path;
  static String audioFocus = _AudioApp.audioFocus.path;
  static String audioPick = _AudioApp.audioPick.path;
  static String audioShortPressLike = _AudioApp.audioShortPressLike.path;
}

/// Audio asset paths (the `audioplayers` package automatically resolves the asset prefix).
enum _AudioApp {
  audioSoundBoxDown('assets/audio/sound_box_down.mp3'),
  audioSoundBoxUp('assets/audio/sound_box_up.mp3'),
  audioFocus('assets/audio/sound_focus.mp3'),
  audioPick('assets/audio/sound_pick.mp3'),
  audioShortPressLike('assets/audio/sound_short_press_like.mp3');

  const _AudioApp(this.path);

  final String path;
}
