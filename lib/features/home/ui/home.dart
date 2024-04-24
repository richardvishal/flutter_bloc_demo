import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/features/cart/ui/cart.dart';
import 'package:flutter_bloc_demo/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc_demo/features/home/ui/product_tile_widget.dart';
import 'package:flutter_bloc_demo/features/wishlist/ui/wishlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current.runtimeType is HomeState,
      buildWhen: (previous, current) => current.runtimeType is! HomeState,
      listener: (BuildContext context, Object? state) {
        if (state is HomeNavigateToWishlistActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Wishlist(),
            ),
          );
        } else if (state is HomeNavigateToCartActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Cart(),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case const (HomeLoadingState):
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case const (HomeLoadedSuccessState):
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'Richie Grocery App',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.teal,
                  // centerTitle: true,
                  actions: [
                    IconButton(
                      onPressed: () {
                        homeBloc.add(
                          HomeWishlistButtonNavigateEvent(),
                        );
                      },
                      icon: const Icon(Icons.favorite_border),
                      color: Colors.white,
                    ),
                    IconButton(
                      onPressed: () {
                        homeBloc.add(
                          HomeCartButtonNavigateEvent(),
                        );
                      },
                      icon: const Icon(Icons.shopping_bag_outlined),
                      color: Colors.white,
                    ),
                  ],
                ),
                body: ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) => ProductTileWidget(
                      productDataModel: successState.products[index]),
                ));
          case const (HomeErrorState):
            return const Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );
          default:
            return const Scaffold(
              body: Center(
                child: Text('Error default'),
              ),
            );
        }
      },
    );
  }
}
