import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/features/auth/presentation/injection_container.dart'
    as di;
import 'package:restaurant/features/auth/presentation/screens/on_boarding_screen.dart';
import 'package:restaurant/features/history/presentation/screens/provider/booking_provider.dart';
import 'package:restaurant/features/home/presentation/bloc/restaurant_bloc.dart';
import 'package:restaurant/features/home/presentation/bloc/restaurant_event.dart';
import 'package:restaurant/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => BookingProvider())],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => di.sl<RestaurantBloc>()..add(LoadRestaurants()),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: OnBoardingScreen(),
    );
  }
}
