extension BytesFormatExtension on int {
  String get toReadableSize {
    const suffixes = ['b', 'kb', 'mb', 'gb', 'tb'];
    double size = toDouble();
    int i = 0;
    while (size >= 1024 && i < suffixes.length - 1) {
      size /= 1024;
      i++;
    }

    if (i == 0) {
      return '${size.toInt()}${suffixes[i]}';
    }

    return '${size.toStringAsFixed(size.truncateToDouble() == size ? 0 : 1)} ${suffixes[i]}';
  }
}
