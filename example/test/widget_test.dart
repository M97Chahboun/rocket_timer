import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MyHomePage widget', () {
    testWidgets('should display the title', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: MyHomePage(title: 'Rocket Timer App'),
      ));
      await tester.pump();
      expect(find.text('Rocket Timer App'), findsOneWidget);
    });

    testWidgets('should display the duration input field',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: MyHomePage(title: 'Rocket Timer App'),
      ));

      await tester.pump();
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('should start the timer when the start button is pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: MyHomePage(title: 'Rocket Timer App'),
      ));

      await tester.enterText(find.byType(TextField), '10');
      await tester.tap(find.text('Start'));
      await tester.pumpAndSettle();

      expect(find.text('00:00:10'), findsOneWidget);
    });

    testWidgets('should pause the timer when the pause button is pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: MyHomePage(title: 'Rocket Timer App'),
      ));

      await tester.enterText(find.byType(TextField), '10');
      await tester.tap(find.text('Start'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Pause'));
      await tester.pumpAndSettle();

      expect(find.text('00:00:10'), findsOneWidget);
    });

    testWidgets('should stop the timer when the stop button is pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: MyHomePage(title: 'Rocket Timer App'),
      ));

      await tester.enterText(find.byType(TextField), '10');
      await tester.tap(find.text('Start'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Stop'));
      await tester.pumpAndSettle();

      expect(find.text('00:00:10'), findsOneWidget);
    });

    testWidgets('should reset the timer when the reset button is pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: MyHomePage(title: 'Rocket Timer App'),
      ));

      await tester.enterText(find.byType(TextField), '10');
      await tester.tap(find.text('Start'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Reset'));
      await tester.pumpAndSettle();

      expect(find.text('00:00:00'), findsOneWidget);
    });

    testWidgets('should switch to countdown mode when the switch is toggled',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: MyHomePage(title: 'Rocket Timer App'),
      ));

      await tester.enterText(find.byType(TextField), '20');
      await tester.tap(find.text('Start'));
      await tester.pumpAndSettle();
      expect(find.text('00:00:20'), findsOneWidget);
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('00:00:21'), findsOneWidget);
      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Start'));
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('00:00:20'), findsOneWidget);
    });
  });
}
