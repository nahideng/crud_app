
import 'package:crud_app/screens/product_screen_list.dart';
import 'package:flutter/material.dart';


class CrudApp extends StatelessWidget {
  const CrudApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Crud App ',
        debugShowCheckedModeBanner: false,
        theme: _lightThemeData(),
        darkTheme: _darkThemeData(),
        themeMode: ThemeMode.system,
        home:const ProductScreenList()
    );
  }

  ThemeData _lightThemeData(){
    return ThemeData(
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.cyan,
          foregroundColor: Colors.white,
          centerTitle: true
      ),

      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple)
        ),

        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple)
        ),

        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)
        ),

        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)
        ),

      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          fixedSize: const Size.fromWidth(double.maxFinite),
          padding: const EdgeInsets.symmetric(vertical: 18,horizontal: 16),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)
          ),
        ),
      ),
    );
  }

  ThemeData _darkThemeData(){
    return ThemeData(
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.cyan,
          foregroundColor: Colors.white,
          centerTitle: true
      ),

      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple)
        ),

        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple)
        ),

        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)
        ),

        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)
        ),

      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          fixedSize: const Size.fromWidth(double.maxFinite),
          padding: const EdgeInsets.symmetric(vertical: 18,horizontal: 16),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)
          ),
        ),
      ),
    );
  }
}
