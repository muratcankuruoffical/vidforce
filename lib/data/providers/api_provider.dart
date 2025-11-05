import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/mock_api_service.dart';

/// Provider for API service
final apiServiceProvider = Provider<MockApiService>((ref) {
  return MockApiService();
});
