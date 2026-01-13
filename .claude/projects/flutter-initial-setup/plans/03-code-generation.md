# Phase 3: 코드 생성 도구

## 목표

> freezed와 riverpod_generator를 설정하여 보일러플레이트 코드를 자동 생성합니다.

## 왜 코드 생성이 필요한가?

### React vs Flutter 비교

```typescript
// TypeScript - 간단
interface User {
  id: string;
  name: string;
  email: string;
}

const user: User = { id: '1', name: 'John', email: 'john@test.com' };
```

```dart
// Dart (수동) - 보일러플레이트가 많음
class User {
  final String id;
  final String name;
  final String email;

  const User({required this.id, required this.name, required this.email});

  // copyWith 메서드
  User copyWith({String? id, String? name, String? email}) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  // == 연산자
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
        other.id == id &&
        other.name == name &&
        other.email == email;
  }

  // hashCode
  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ email.hashCode;

  // JSON 변환
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email};
  }
}
```

```dart
// Dart + freezed - TypeScript처럼 간단!
@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String email,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
// 나머지는 자동 생성됨!
```

## 태스크 요약

| ID | 태스크 | 상태 |
|----|--------|------|
| TASK-0301 | build.yaml 설정 | ✅ |
| TASK-0302 | freezed 예제 모델 생성 | ✅ |
| TASK-0303 | 코드 생성 실행 및 확인 | ✅ |

---

## TASK-0301: build.yaml 설정

### 개요

| 항목 | 내용 |
|------|------|
| **상태** | ✅ 완료 |
| **선행 조건** | Phase 2 완료 |

### 왜 필요한가?

`build.yaml`은 코드 생성기의 설정 파일입니다.
생성 옵션을 세밀하게 조정할 수 있습니다.

### 체크리스트

#### 1단계: build.yaml 생성

프로젝트 루트에 `build.yaml` 생성:

```yaml
targets:
  $default:
    builders:
      # freezed 설정
      freezed:
        options:
          # copyWith 메서드 생성
          copy_with: true
          # == 연산자 생성
          equal: true
          # toString 메서드 생성 (디버깅용)
          to_string: true
          # fromJson/toJson 생성 (json_serializable 사용 시)
          from_json: true
          to_json: true

      # json_serializable 설정
      json_serializable:
        options:
          # 명시적으로 지정된 필드만 JSON에 포함
          explicit_to_json: true
          # 알 수 없는 키 무시 (API 응답이 변경되어도 에러 안 남)
          checked: false
          # 필드 이름 자동 변환 (camelCase ↔ snake_case)
          field_rename: snake

      # riverpod_generator 설정
      riverpod_generator:
        options:
          # Provider 이름에 자동으로 'Provider' 접미사 추가
          provider_name_prefix: ""
```

### Claude Code 지침

```markdown
TASK-0301을 진행해줘.
프로젝트 루트에 build.yaml 파일을 위 내용으로 생성해줘.
```

### 완료 기준

- [ ] `build.yaml` 파일 생성됨

### 사용자 검수 포인트

1. build.yaml이 프로젝트 루트에 있는지 확인
2. 설정 내용이 올바른지 확인

---

## TASK-0302: freezed 예제 모델 생성

### 개요

| 항목 | 내용 |
|------|------|
| **상태** | ✅ 완료 |
| **선행 조건** | TASK-0301 완료 |

### freezed 사용법

freezed 파일은 3부분으로 구성됩니다:
1. **원본 파일** (직접 작성): `user.dart`
2. **freezed 생성 파일** (자동): `user.freezed.dart`
3. **JSON 생성 파일** (자동): `user.g.dart`

### 체크리스트

#### 1단계: 예제 모델 생성

`lib/shared/models/user.dart`:

```dart
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
```

#### freezed 문법 설명

| 요소 | 설명 | TypeScript 비유 |
|------|------|----------------|
| `@freezed` | 클래스를 불변으로 만듦 | `readonly` |
| `with _$User` | 생성된 코드 믹스인 | - |
| `const factory User(...)` | 생성자 정의 | `interface User {...}` |
| `= _User` | 실제 구현 클래스 | - |
| `required` | 필수 필드 | 기본값 없는 필드 |
| `@JsonKey(name: ...)` | JSON 키 매핑 | - |
| `part '*.freezed.dart'` | 생성 파일 연결 | - |

### Claude Code 지침

```markdown
TASK-0302를 진행해줘.
lib/shared/models/user.dart 파일을 위 내용으로 생성해줘.
```

### 완료 기준

- [ ] `lib/shared/models/user.dart` 생성됨

### 사용자 검수 포인트

1. 파일 내용이 freezed 문법에 맞는지 확인
2. `part` 지시문이 올바른지 확인

---

## TASK-0303: 코드 생성 실행 및 확인

### 개요

| 항목 | 내용 |
|------|------|
| **상태** | ✅ 완료 |
| **선행 조건** | TASK-0302 완료 |

### 코드 생성 명령어

```bash
# 한 번 실행 (변경 감지 안 함)
dart run build_runner build

# 기존 생성 파일 삭제 후 재생성
dart run build_runner build --delete-conflicting-outputs

# 파일 변경 감지하며 자동 실행 (개발 중 권장)
dart run build_runner watch
```

### 체크리스트

#### 1단계: 코드 생성 실행

```bash
dart run build_runner build --delete-conflicting-outputs
```

#### 2단계: 생성된 파일 확인

다음 파일들이 생성되어야 함:
- `lib/shared/models/user.freezed.dart`
- `lib/shared/models/user.g.dart`

#### 3단계: 생성된 코드 내용 확인

`user.freezed.dart`에는:
- `copyWith()` 메서드
- `==` 연산자
- `hashCode`
- `toString()`

`user.g.dart`에는:
- `_$UserFromJson()`
- `_$UserToJson()`

### Claude Code 지침

```markdown
TASK-0303을 진행해줘.
dart run build_runner build --delete-conflicting-outputs를 실행하고,
생성된 파일 목록을 보여줘.
```

### 완료 기준

- [ ] `user.freezed.dart` 생성됨
- [ ] `user.g.dart` 생성됨
- [ ] `flutter analyze` 에러 없음

### 사용자 검수 포인트

1. `.freezed.dart`, `.g.dart` 파일이 생성되었는지 확인
2. 빌드 에러가 없는지 확인
3. (선택) 생성된 파일 내용 살펴보기

---

## 사용 예시 (참고)

```dart
// User 생성
final user = User(
  id: '1',
  name: 'John',
  email: 'john@test.com',
  createdAt: DateTime.now(),
);

// copyWith - 일부 필드만 변경한 새 객체
final updatedUser = user.copyWith(name: 'Jane');
// user.name = 'Jane'; // ❌ 불변이라 직접 수정 불가

// JSON 변환
final json = user.toJson();  // Map<String, dynamic>
final fromApi = User.fromJson(apiResponse);

// 비교 (== 연산자 자동 생성됨)
print(user == updatedUser);  // false
```

---

## 진행 현황

```
Phase 3 진행률: [██████████] 100% ✅

TASK-0301 (build.yaml):   [██████████] 100% ✅
TASK-0302 (freezed 모델): [██████████] 100% ✅
TASK-0303 (코드 생성):    [██████████] 100% ✅
```

### 완료 내역

**2026-01-13 완료**

1. **TASK-0301**: build.yaml 설정
   - freezed, json_serializable, riverpod_generator 설정 추가
   - copyWith, equal, toString, fromJson, toJson 옵션 활성화
   - field_rename: snake 설정으로 camelCase ↔ snake_case 자동 변환

2. **TASK-0302**: freezed 예제 모델 생성
   - lib/shared/models/user.dart 생성
   - @freezed 어노테이션 적용
   - @JsonKey로 created_at 필드 매핑
   - part 지시문으로 생성 파일 연결

3. **TASK-0303**: 코드 생성 실행 및 확인
   - `dart run build_runner build --delete-conflicting-outputs` 실행
   - user.freezed.dart 생성 (copyWith, ==, hashCode, toString)
   - user.g.dart 생성 (fromJson, toJson)
   - analysis_options.yaml에 invalid_annotation_target: ignore 추가
   - `flutter analyze` 통과 (No issues found)

## 다음 단계

Phase 3 완료 후 → [Phase 4: 테마 설정](./04-theme-config.md)로 이동
