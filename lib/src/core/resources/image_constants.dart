final class ImageConstants {
  static String like = _ImageApp.imageLike.path;
  static String love = _ImageApp.imageLove.path;
  static String care = _ImageApp.imageCare.path;
  static String haha = _ImageApp.imageHaha.path;
  static String wow = _ImageApp.imageWow.path;
  static String sad = _ImageApp.imageSad.path;
  static String angry = _ImageApp.imageAngry.path;
}

enum _ImageApp {
  imageLike('assets/images/like.png'),
  imageLove('assets/images/love.png'),
  imageCare('assets/images/care.png'),
  imageHaha('assets/images/haha.png'),
  imageWow('assets/images/wow.png'),
  imageSad('assets/images/sad.png'),
  imageAngry('assets/images/angry.png');

  const _ImageApp(this.path);

  final String path;
}
