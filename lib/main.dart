import 'package:sha/base/app_start.dart';

Future<void> main() async => ShaApp().startApp();

class ShaApp extends AppStart {
  ShaApp() : super();
}
// flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs