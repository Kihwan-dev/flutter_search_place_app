# 🏪 장소 검색 및 리뷰 앱

Flutter로 개발된 장소 검색 및 리뷰 플랫폼입니다. 사용자는 장소를 검색하고, 리뷰를 작성하며, 다른 사용자들의 리뷰를 확인할 수 있습니다.

## ✨ 주요 기능

### 🔍 장소 검색
- **텍스트 검색**: 키워드로 장소 검색
- **현재 위치 기반 검색**: GPS를 활용한 주변 장소 검색
- **실시간 검색 결과**: 검색어 입력 시 즉시 결과 표시

### 📝 리뷰 시스템
- **리뷰 작성**: 장소에 대한 리뷰 작성
- **리뷰 조회**: 다른 사용자들의 리뷰 확인
- **리뷰 수정/삭제**: 본인이 작성한 리뷰 관리
- **실시간 업데이트**: Firebase Firestore를 통한 실시간 동기화

## 🛠 기술 스택

### Frontend
- **Flutter**: 크로스 플랫폼 모바일 앱 개발
- **Dart**: 프로그래밍 언어
- **Riverpod**: 상태 관리
- **Material Design**: UI 컴포넌트

### Backend & Database
- **Firebase Firestore**: NoSQL 데이터베이스
- **Firebase Core**: Firebase 서비스 초기화

### 외부 API & 서비스
- **Kakao Local API**: 장소 검색 API
- **Geolocator**: 위치 서비스
- **Dio**: HTTP 클라이언트

## 📁 프로젝트 구조

```
lib/
├── main.dart                 # 앱 진입점
├── firebase_options.dart     # Firebase 설정
├── core/
│   └── geolocator_helper.dart # 위치 서비스 헬퍼
├── data/
│   ├── models/
│   │   ├── place.dart        # 장소 모델
│   │   └── review.dart       # 리뷰 모델
│   └── repositories/
│       └── review_repository.dart # 리뷰 데이터 관리
└── ui/
    ├── pages/
    │   ├── home/
    │   │   ├── home_page.dart      # 홈 페이지
    │   │   └── home_view_model.dart # 홈 페이지 상태 관리
    │   └── review/
    │       ├── review_page.dart      # 리뷰 페이지
    │       └── review_view_model.dart # 리뷰 페이지 상태 관리
    └── widgets/              # 재사용 가능한 위젯들
```

## 🚀 시작하기

### 필수 요구사항
- Flutter SDK (3.0.0 이상)
- Dart SDK
- Android Studio / VS Code
- Firebase 프로젝트

### 설치 및 실행

1. **저장소 클론**
   ```bash
   git clone [repository-url]
   cd flutter_search_place_app
   ```

2. **의존성 설치**
   ```bash
   flutter pub get
   ```

3. **Firebase 설정**
   - Firebase 콘솔에서 새 프로젝트 생성
   - `firebase_options.dart` 파일 업데이트
   - Firestore 데이터베이스 생성

4. **API 키 설정**
   - Kakao Local API 키 발급
   - 관련 설정 파일에 API 키 추가

5. **앱 실행**
   ```bash
   flutter run
   ```

## 📱 사용 방법

### 장소 검색
1. 홈 화면의 검색창에 키워드 입력
2. 또는 우상단 GPS 버튼을 눌러 현재 위치 기반 검색
3. 검색 결과 목록에서 원하는 장소 선택

### 리뷰 작성
1. 장소 상세 페이지로 이동
2. 하단 텍스트 필드에 리뷰 내용 입력
3. 엔터 키를 눌러 리뷰 등록

### 리뷰 관리
1. 리뷰를 길게 누르기
2. 수정/삭제 옵션 선택
3. 수정 시 다이얼로그에서 내용 편집
4. 삭제 시 확인 후 삭제

## 🔧 주요 의존성

```yaml
dependencies:
  flutter: sdk: flutter
  flutter_riverpod: ^2.6.1      # 상태 관리
  geolocator: ^14.0.2           # 위치 서비스
  dio: ^5.8.0+1                 # HTTP 클라이언트
  firebase_core: ^4.0.0         # Firebase 코어
  cloud_firestore: ^6.0.0       # Firestore 데이터베이스
```

## 🎨 UI/UX 특징

- **Material Design**: Google의 Material Design 가이드라인 준수
- **반응형 레이아웃**: 다양한 화면 크기 지원
- **직관적인 네비게이션**: 명확한 화면 전환
- **터치 피드백**: 사용자 액션에 대한 시각적 피드백
- **로딩 상태**: 데이터 로딩 중 적절한 인디케이터

## 🔒 보안 및 권한

### 위치 권한
- 앱 사용 시 위치 권한 요청
- 권한 거부 시 기본 검색 기능만 사용 가능

### 데이터 보안
- Firebase Firestore 보안 규칙 설정
- 사용자별 데이터 접근 제어
- 
---
