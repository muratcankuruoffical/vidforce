/// Type of media that can be generated
enum MediaType {
  image,
  video;

  String get displayName {
    switch (this) {
      case MediaType.image:
        return 'IMAGE';
      case MediaType.video:
        return 'VIDEO';
    }
  }

  String get icon {
    switch (this) {
      case MediaType.image:
        return '🖼️';
      case MediaType.video:
        return '🎬';
    }
  }
}
