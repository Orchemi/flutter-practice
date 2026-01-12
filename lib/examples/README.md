# Flutter Examples

이 폴더는 Flutter 학습을 위한 참고 예제 코드를 보관합니다.

## counter_example.dart

Flutter가 기본으로 생성하는 카운터 앱 예제입니다.

### 학습 포인트

1. **StatefulWidget 사용법**
   - `MyHomePage`: StatefulWidget 클래스
   - `_MyHomePageState`: State 클래스

2. **상태 관리**
   - `setState()`: 상태 변경 및 UI 업데이트
   - `_counter`: private 상태 변수

3. **기본 위젯**
   - `Scaffold`: 앱의 기본 구조
   - `AppBar`: 상단 바
   - `FloatingActionButton`: 플로팅 액션 버튼
   - `Center`, `Column`: 레이아웃 위젯

4. **이벤트 핸들링**
   - `onPressed`: 버튼 클릭 이벤트
   - `_incrementCounter`: 이벤트 핸들러 함수

### 실행 방법

이 예제를 실행하려면 `lib/main.dart`의 내용을 이 파일로 교체한 후:

```bash
flutter run
```

### React와 비교

| React | Flutter |
|-------|---------|
| `useState` | `setState` + State 클래스 |
| Function Component | StatelessWidget |
| Class Component | StatefulWidget |
| `onClick` | `onPressed` |
