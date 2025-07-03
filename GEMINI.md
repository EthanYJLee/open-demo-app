# Gemini - 프로젝트 명세서

이 문서는 Gemini가 프로젝트의 맥락을 이해하고 일관성 있는 지원을 제공하기 위한 중앙 지식 베이스입니다.

---

### 1. 프로젝트 개요 (Project Overview)

- **목표**: 커뮤니티 기능을 갖춘 공간 예약 앱입니다.
- **주요 기능**: 지점/공간 목록 조회, 시간 단위 예약, 커뮤니티 게시판

---

### 2. 기술 스택 및 아키텍처 (Tech Stack & Architecture)

- **주요 기술**: 
  - **프레임워크**: Flutter
  - **백엔드**: Supabase
  - **상태관리**: Riverpod
  - **라우팅**: GetX
  - **환경변수**: flutter_dotenv

- **아키텍처 원칙**:
  - 데이터 관련 로직은 `lib/providers/`의 Riverpod Provider에서 처리합니다.
  - 화면 이동 및 라우팅은 GetX를 사용합니다.
  - UI는 `lib/pages/` (전체 화면)와 `lib/widgets/` (공용 컴포넌트)로 분리합니다.

---

### 3. 주요 파일 및 디렉토리 구조 (Key File Locations)

- **환경 변수**: `assets/config/.env`
- **데이터 모델**: `lib/models/`
- **데이터 프로바이더**: `lib/providers/`
- **메인 로직**: `lib/main.dart`
- **UI 페이지**: `lib/pages/`

---

### 4. 개발 워크플로우 (Development Workflow)

- **앱 실행**: `flutter run`
- **코드 생성**: `flutter pub run build_runner watch --delete-conflicting-outputs` (Riverpod Generator 사용 시 필요)
- **테스트**: 현재 별도의 테스트 스크립트는 없습니다.

---

### 5. 장기적인 목표 및 현재 상태 (Roadmap & Status)

- **현재 진행 상황**: Supabase 연동 초기 단계. `.env` 설정을 마치고 `main.dart`에 초기화 코드 적용 완료. 현재 Supabase에 데이터가 없으므로, 모든 Provider는 `fake_data.dart`를 사용하도록 되돌려진 상태입니다.
- **다음 목표**: Supabase 테이블에 데이터가 채워지면, `fake_data.dart`를 사용하는 Provider들을 실제 Supabase API를 호출하도록 수정하는 작업.

---

### 6. 변경 이력 (Change Log)

- **2025년 7월 3일**: `lib/models/user.dart` 파일을 `lib/models/profile.dart`로 변경하고, `User` 클래스명을 `Profile`로 수정. 관련 코드 참조도 모두 업데이트 완료.
