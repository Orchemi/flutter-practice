import 'package:freezed_annotation/freezed_annotation.dart';

// 생성될 파일 import (아직 없어도 OK)
part 'user.freezed.dart';
part 'user.g.dart';

/// 사용자 모델
///
/// TypeScript의 interface와 동일한 역할
/// ```typescript
/// interface User {
///   id: string;
///   name: string;
///   email: string;
///   createdAt: Date;
/// }
/// ```
@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String email,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _User;

  /// JSON → User 변환 (API 응답 파싱)
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
