## EduPulse-QR — Copilot instructions

Short, targeted guidelines for AI agents editing this repo.

- Project type: Flutter app (multi-platform). Entry: `lib/main.dart`.
- Big picture: small school app with two primary roles: teacher and parent. UI is organized under `lib/screens/`. Business logic and external calls belong in `lib/services/` (currently `firebase_service.dart` and `qr_service.dart` are placeholders).

- Key files to inspect when changing behavior:
  - `lib/main.dart` — routes and app entry. Routes: `'/'`, `'/teacher_dashboard'`, `'/parent_dashboard'`.
  - `lib/screens/login_screen.dart` — mock login flow; stores `token`, `role`, `name` in `SharedPreferences`.
  - `lib/screens/dashboard_teacher_screen.dart` — teacher dashboard using `fl_chart` for charts.
  - `lib/screens/dashboard_screen.dart` — parent dashboard example UI.
  - `lib/utils/constants.dart` — app-level strings and simple constants.

- Patterns and conventions discovered in code:
  - Lightweight, local-first approach: authentication is mocked in `login_screen.dart`. Persisted state uses `shared_preferences` for `token` and `role`.
  - Place API/network logic inside `lib/services/`. If adding network calls, create functions here and keep UI screens thin.
  - UI widgets are implemented as Stateful/Stateless Widgets under `lib/screens/`. Follow existing naming: `<feature>_screen.dart` for parent-facing screens and `dashboard_teacher_screen.dart` for teacher views.
  - No global state management library is present (no Provider, Riverpod, Bloc). Introduce one only if necessary and document reasons.

- Build / run / debug (commands expected to work from repo root):
  - Get deps: `flutter pub get`
  - Run on connected mobile device or desktop (Windows): `flutter run` or `flutter run -d windows`
  - Run web: `flutter run -d chrome`
  - Build APK: `flutter build apk`
  - Run tests (none present, but standard runner): `flutter test`

- Important dependencies (see `pubspec.yaml`): `shared_preferences`, `http`, `fl_chart`, `cupertino_icons`.

- Integration points and where to hook features:
  - Persisted auth: `SharedPreferences` keys used in `login_screen.dart`: `token`, `role`, `name`.
  - Charts: `fl_chart` used in `dashboard_teacher_screen.dart` — look here for visuals and sample data usage.
  - QR features: `lib/services/qr_service.dart` exists as the intended place for QR scanning/encoding logic.
  - Firebase: `lib/services/firebase_service.dart` placeholder — if integrating Firebase, implement initialization and data calls here.

- Examples (copy/paste friendly):
  - After login, navigation used: `Navigator.pushReplacementNamed(context, '/teacher_dashboard');`
  - Save token: `SharedPreferences prefs = await SharedPreferences.getInstance(); await prefs.setString('token', token);`

- Editing rules for AI agents:
  - Prefer small, focused PRs that change a single feature or file group (UI vs service).
  - Keep UI code in `lib/screens/` and service/IO in `lib/services/`.
  - When adding a new package, update `pubspec.yaml` and run `flutter pub get` locally; add a short note in the PR description explaining why.
  - Preserve existing UI text (app appears localized/Malay). If changing text, search `lib/` for other occurrences and update consistently.

If anything here is unclear or you want more project-specific rules (naming, branching, tests to add), tell me which area to expand and I'll update this file.
