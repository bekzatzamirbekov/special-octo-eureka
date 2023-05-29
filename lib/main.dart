import 'package:flutter/material.dart'
    hide ThemeMode; // Hide the conflicting ThemeMode
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/them_cubit.dart';
import 'screens/home_screen.dart';
import 'cubits/credit_cubit.dart';
import 'utils/theme_utils.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<CreditCubit>(
      create: (context) {
        final creditCubit = CreditCubit();
        creditCubit.fetchCredits(); // Fetch credits when the app starts
        return creditCubit;
      },
    ),
    BlocProvider<ThemeCubit>(
      create: (context) => ThemeCubit(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  bool isDarkModeEnabled = true;

  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          title: 'Credit App',
          theme: ThemeData(
            useMaterial3: true,
            primarySwatch: myColor, // Set the primary color to green
            brightness: themeMode == ThemeMode.dark
                ? Brightness.dark
                : Brightness.light,
          ),
          home: const HomeScreen(),
        );
      },
    );
  }
}
