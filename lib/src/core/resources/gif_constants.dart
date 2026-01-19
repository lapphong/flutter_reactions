// coverage:ignore-file
final class GifConstants {
  static String like = _GifApp.gifLike.path;
  static String love = _GifApp.gifLove.path;
  static String care = _GifApp.gifCare.path;
  static String haha = _GifApp.gifHaha.path;
  static String wow = _GifApp.gifWow.path;
  static String sad = _GifApp.gifSad.path;
  static String angry = _GifApp.gifAngry.path;
}

enum _GifApp {
  gifLike('assets/gif/like.gif'),
  gifLove('assets/gif/love.gif'),
  gifCare('assets/gif/care.gif'),
  gifHaha('assets/gif/haha.gif'),
  gifWow('assets/gif/wow.gif'),
  gifSad('assets/gif/sad.gif'),
  gifAngry('assets/gif/angry.gif');

  const _GifApp(this.path);

  final String path;
}
