import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:bicicoruna/views/home_screen.dart';
import 'package:bicicoruna/viewmodels/station_viewmodel.dart';

void main() {
  testWidgets('Integración Top-Down: La UI carga correctamente', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => StationViewModel()),
        ],
        child: MaterialApp(home: HomeScreen()),
      ),
    );

    expect(find.text('BiciCoruña'), findsOneWidget);
    expect(find.text('Selección de estación...'), findsOneWidget);
  });
}