import 'package:flutter/material.dart';
import 'package:flutter_advanced_2025/app/blocs/report.bloc.dart';
import 'package:flutter_advanced_2025/app/constant/color.constant.dart';
import 'package:flutter_advanced_2025/app/model/product.dart';
import 'package:flutter_advanced_2025/app/supplemental/cut_corners_border.dart';
import 'package:flutter_advanced_2025/app/view/menu.page.dart';
import 'package:flutter_advanced_2025/app/view/report.page.dart';
import 'package:flutter_advanced_2025/app/widget/backdrop.widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'view/home.dart';
import 'view/login.dart';

final ThemeData _kShrineTheme = _buildShrineTheme();

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light(useMaterial3: true);
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: kShrinePink100,
      secondary: kShrineBrown900,
      onPrimary: kShrineBrown900,
      error: kShrineErrorRed
    ),
    textTheme: _buildShrineTextTheme(base.textTheme),
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: kShrinePink100
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: CutCornersBorder(),
      focusedBorder: CutCornersBorder(
        borderSide: BorderSide(
          width: 2,
          color: kShrineBrown900
        )
      ),
      floatingLabelStyle: TextStyle(
        color: kShrineBrown900
      ),
    ),
    appBarTheme: const AppBarTheme(
      foregroundColor: kShrineBrown900,
      backgroundColor: kShrinePink100,
    )
  );
}

TextTheme _buildShrineTextTheme(TextTheme base){
  return base.copyWith(
    headlineSmall: base.headlineSmall!.copyWith(fontWeight: FontWeight.w500),
    titleLarge: base.titleLarge!.copyWith(fontSize: 18),
    bodySmall: base.bodySmall!.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14
    ),
    bodyLarge: base.bodyLarge!.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 16
    )
  ).apply(
    fontFamily: 'Rubik',
    displayColor: kShrineBrown900,
    bodyColor: kShrineBrown900
  );
}

class ShrineApp extends StatefulWidget {
  const ShrineApp({super.key});

  @override
  State<ShrineApp> createState() => _ShrineAppState();
}

class _ShrineAppState extends State<ShrineApp> {
  Category _currentCategory = Category.all;

  void _onCategoryTap(Category category){
    setState(() {
      _currentCategory = category;
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReportBloc(),
      child: MaterialApp(
        title: 'Shrine',
        initialRoute: '/',
        routes: {
          '/report': (BuildContext context) => ReportListPage(),
          '/login': (BuildContext context) => const LoginPage(),
          '/': (BuildContext context) => Backdrop(
            frontLayer: HomePage(category: _currentCategory,), 
            // backLayer: Container(color: kShrinePink100,), 
            backLayer: MenuPage(currentCategory: _currentCategory, onCategoryTap: _onCategoryTap),
            frontTitle: Text('Shrine'), 
            backTitle: Text('Menu'), 
            currentCategory: Category.all
          )
          // '/': (BuildContext context) => const HomePage(),
        },
        theme: _kShrineTheme
      ),
    );
  }
}

