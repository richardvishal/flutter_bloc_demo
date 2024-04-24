import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/features/cart/ui/cart.dart';
import 'package:flutter_bloc_demo/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc_demo/features/wishlist/ui/wishlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeState,
      buildWhen: (previous, current) => current is! HomeState,
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
      builder: (BuildContext context, state) {
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
          body: const Center(
            child: Text('Home'),
          ),
        );
      },
    );
  }
}
