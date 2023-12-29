class ImageExtension {
  static const svg = 'svg';
  static const png = 'png';
  static const jpg = 'jpg';

  static String? getFromPokemonUrl(String? url) {
    if (url == null) return null;

    var urlSplit = url.split('/');
    return urlSplit.last.split('.').first;
  }
}
