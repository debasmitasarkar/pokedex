import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/constants/color_constants.dart';
import 'package:pokedex/presentation/injector.dart';
import 'package:pokedex/presentation/pages/home/home_screen.dart';
import 'package:pokedex/presentation/pages/pokemon_detail/pokemon_detail_screen.dart';
import 'package:pokedex/presentation/pages/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injector.init();
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      theme: ThemeData(
        sliderTheme: SliderTheme.of(context).copyWith(
          trackHeight: 4,
          thumbShape: SliderComponentShape.noThumb,
          overlayShape: SliderComponentShape.noThumb,
        ),
        fontFamily: 'NotoSans-Regular',
        primaryColor: ColorConstants.primaryBlue,
      ),
      home: const SplashScreen(),
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == 'pokemonDetail') {
          final Map<String, dynamic> value =
              settings.arguments as Map<String, dynamic>; // Retrieve the value.
          return MaterialPageRoute(
            builder: (_) => PokemonDetailScreen(
              pokemonDetailEntity: value['detail'],
            ),
          ); // Pass it to BarPage.
        }
        return null;
      },
      routes: {
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
