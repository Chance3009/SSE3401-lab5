import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lab5/main.dart' as app;
import 'package:lab5/screens/activation_screen.dart';
import 'package:lab5/screens/engineer_screen.dart';
import 'package:lab5/screens/home_screen.dart';
import 'package:lab5/screens/invitation_screen.dart';
import 'package:lab5/screens/settings_screen.dart';
import 'package:lab5/widgets/factory_carousel.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("app test", () {
    testWidgets(
      "test normal flow",
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextField), "102937895");
        await Future.delayed(const Duration(seconds: 3));
        await tester.tap(find.byType(Checkbox));
        await Future.delayed(const Duration(seconds: 2));
        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        expect(find.byType(OTPCard), findsOneWidget);

        await tester.enterText(find.byType(TextField).at(0), "1");
        await Future.delayed(const Duration(seconds: 1));
        await tester.enterText(find.byType(TextField).at(1), "2");
        await Future.delayed(const Duration(seconds: 1));
        await tester.enterText(find.byType(TextField).at(2), "3");
        await Future.delayed(const Duration(seconds: 1));
        await tester.enterText(find.byType(TextField).at(3), "1");
        await Future.delayed(const Duration(seconds: 1));
        await tester.enterText(find.byType(TextField).at(4), "2");
        await Future.delayed(const Duration(seconds: 1));
        await tester.enterText(find.byType(TextField).at(5), "3");
        await Future.delayed(const Duration(seconds: 2));
        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        expect(find.byType(HomePage), findsOneWidget);

        await Future.delayed(const Duration(seconds: 2));
        await tester.tap(find.byType(FactoryCard).at(1));
        await Future.delayed(const Duration(seconds: 2));

        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key("User")));
        await tester.pumpAndSettle();

        expect(find.byType(EngineerPage), findsOneWidget);

        await Future.delayed(const Duration(seconds: 2));
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();

        expect(find.byType(InvitationPage), findsOneWidget);

        await Future.delayed(const Duration(seconds: 1));
        await tester.enterText(find.byType(TextField).at(0), "Test Owner Name");
        await Future.delayed(const Duration(seconds: 1));
        await tester.enterText(find.byType(TextField).at(1), "1456956");
        await Future.delayed(const Duration(seconds: 1));
        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        expect(find.byType(EngineerPage), findsOneWidget);

        await Future.delayed(const Duration(seconds: 1));
        await tester.tap(find.byKey(const Key("Settings")));
        await tester.pumpAndSettle();

        expect(find.byType(SettingsPage), findsOneWidget);

        await Future.delayed(const Duration(seconds: 1));
        await tester.tap(find.byIcon(Icons.edit));
        await tester.pumpAndSettle();

        expect(find.byType(TextField), findsWidgets);

        await Future.delayed(const Duration(seconds: 1));
        await tester.enterText(find.byType(TextField).at(1), "5");
        await Future.delayed(const Duration(seconds: 3));
        await tester.tap(find.byIcon(Icons.check));
      },
    );
  });
}
