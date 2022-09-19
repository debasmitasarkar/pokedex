import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/constants/color_constants.dart';
import 'package:pokedex/constants/image_constants.dart';
import 'package:pokedex/domain/entities/pokemon_detail_entity.dart';
import 'package:pokedex/presentation/pages/home/home_screen_controller.dart';
import 'package:pokedex/presentation/widgets/all_pokemon_widget.dart';
import 'package:pokedex/presentation/widgets/favourites_widget.dart';
import 'package:pokedex/presentation/widgets/home_screen_appbar_title.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    ref.read(homeScreenControllerProvider).getFavourites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: HomeScreenAppBarTitle(),
            bottom: TabBar(
              indicatorWeight: 4,
              indicatorColor: ColorConstants.primaryBlue,
              tabs: [
                const Tab(
                  child: Text(
                    'All pokemons',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                Tab(
                  child: Row(
                    children: [
                      const Text(
                        'Favourites',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Consumer(builder: (context, ref, child) {
                        List<PokemonDetailEntity> favouriteList =
                            ref.watch(favouriteListProvider);
                        int count = favouriteList.length;
                        return count == 0
                            ? const SizedBox.shrink()
                            : Container(
                                height: 20,
                                width: 20,
                                alignment: FractionalOffset.center,
                                decoration: BoxDecoration(
                                    color: ColorConstants.primaryBlue,
                                    borderRadius: BorderRadius.circular(40)),
                                child: Text(
                                  count.toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              );
                      })
                    ],
                  ),
                ),
              ],
            )),
        body: const TabBarView(
          children: [
            AllPokemonWidget(),
            FavouritesWidget(),
          ],
        ),
      ),
    );
  }
}
