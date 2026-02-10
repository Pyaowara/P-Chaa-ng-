/// Utility functions for URL handling
class UrlUtils {
  UrlUtils._();

  /// Converts image URLs to be displayable on Android emulator
  /// Replaces 'localhost' with '10.0.2.2' for emulator access
  static String getDisplayableImageUrl(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) return '';
    return imageUrl.replaceAll('localhost', '10.0.2.2');
  }
}
