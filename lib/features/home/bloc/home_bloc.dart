import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_demo/data/cart_items.dart';
import 'package:flutter_bloc_demo/data/grocery_list.dart';
import 'package:flutter_bloc_demo/data/wishlist_items.dart';
import 'package:flutter_bloc_demo/features/home/models/product_data_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(
      homeInitialEvent,
    );
    on<HomeProductWishlistButtonClickedEvent>(
      homeProductWishlistButtonClickedEvent,
    );
    on<HomeProductCartButtonClickedEvent>(
      homeProductCartButtonClickedEvent,
    );
    on<HomeWishlistButtonNavigateEvent>(
      homeWishlistButtonNavigateEvent,
    );

    on<HomeCartButtonNavigateEvent>(
      homeCartButtonNavigateEvent,
    );
  }
  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(
      const Duration(seconds: 3),
    );

    emit(
      HomeLoadedSuccessState(
        products: GroceryList.groceryProducts
            .map(
              (e) => ProductDataModel(
                  id: e['id'],
                  name: e['name'],
                  description: e['description'],
                  price: e['price'],
                  imageUrl: e['imageUrl']),
            )
            .toList(),
      ),
    );
  }

  FutureOr<void> homeProductWishlistButtonClickedEvent(
      HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    print('Wishlist Button Clicked');
    wishlistItems.add(event.clickedProduct);
    emit(HomeProductItemWishlistedActionState());
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    print('Cart Button Clicked');
    cartItems.add(event.clickedProduct);
    emit(HomeProductItemCartedActionState());

  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('Wishlist Navigate');
    emit(HomeNavigateToWishlistActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('Cart Navigate');
    emit(HomeNavigateToCartActionState());
  }
}
