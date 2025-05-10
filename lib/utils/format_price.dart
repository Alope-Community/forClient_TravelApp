String formatPrice(String rawPrice) {
  try {
    final parsed = int.parse(rawPrice);
    return parsed
        .toStringAsFixed(0)
        .replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.');
  } catch (_) {
    return rawPrice;
  }
}
