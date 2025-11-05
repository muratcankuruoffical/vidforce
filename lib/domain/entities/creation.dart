import 'media_type.dart';

/// Status of a creation/generation
enum CreationStatus {
  queued,
  processing,
  done,
  failed;

  String get displayName {
    switch (this) {
      case CreationStatus.queued:
        return 'Queued';
      case CreationStatus.processing:
        return 'Processing';
      case CreationStatus.done:
        return 'Done';
      case CreationStatus.failed:
        return 'Failed';
    }
  }

  bool get isCompleted => this == CreationStatus.done;
  bool get isFailed => this == CreationStatus.failed;
  bool get isProcessing =>
      this == CreationStatus.queued || this == CreationStatus.processing;
}

/// Creation entity representing a generated media item
class Creation {
  final String id;
  final String templateId;
  final String templateTitle;
  final MediaType type;
  final CreationStatus status;
  final String? mediaUrl;
  final String? thumbnailUrl;
  final DateTime createdAt;
  final int creditsCost;
  final String? errorMessage;
  final double? progress;
  final bool isFavorite;

  const Creation({
    required this.id,
    required this.templateId,
    required this.templateTitle,
    required this.type,
    required this.status,
    this.mediaUrl,
    this.thumbnailUrl,
    required this.createdAt,
    required this.creditsCost,
    this.errorMessage,
    this.progress,
    this.isFavorite = false,
  });

  Creation copyWith({
    String? id,
    String? templateId,
    String? templateTitle,
    MediaType? type,
    CreationStatus? status,
    String? mediaUrl,
    String? thumbnailUrl,
    DateTime? createdAt,
    int? creditsCost,
    String? errorMessage,
    double? progress,
    bool? isFavorite,
  }) {
    return Creation(
      id: id ?? this.id,
      templateId: templateId ?? this.templateId,
      templateTitle: templateTitle ?? this.templateTitle,
      type: type ?? this.type,
      status: status ?? this.status,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      createdAt: createdAt ?? this.createdAt,
      creditsCost: creditsCost ?? this.creditsCost,
      errorMessage: errorMessage ?? this.errorMessage,
      progress: progress ?? this.progress,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
