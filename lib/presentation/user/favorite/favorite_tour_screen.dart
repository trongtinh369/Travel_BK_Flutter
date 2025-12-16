import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/presentation/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/favorite_cubit.dart';
import 'cubit/favorite_state.dart';
import 'favorite_tour_card.dart';

class FavoriteTourScreen extends StatefulWidget {
  const FavoriteTourScreen({super.key});

  @override
  State<FavoriteTourScreen> createState() => _FavoriteTourScreenState();
}

class _FavoriteTourScreenState extends State<FavoriteTourScreen> {

  @override
  Widget build(BuildContext context) {
    final FavoriteCubit _cubit = context.read<FavoriteCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Yêu thích',
          style: TextStyle(color: AppColors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.backgroundAppBarTheme,
      ),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        bloc: _cubit,
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FavoriteError) {
            return Center(child: Text(state.message));
          }

          if (state is FavoriteLoaded) {
            final favorites = state.favorites;

            if (favorites.isEmpty) {
              return const Center(child: Text('Không có tour yêu thích'));
            }

            return ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final favorite = favorites[index];
                return FavoriteTourCard(
                  favorite: favorite,
                  isFavorite: true,
                  onFavoriteToggle: () {
                    _cubit.removeFavorite(
                      tourId: favorite.tourId,
                      userId: favorite.userId,
                    );
                  },
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      'danh_sach_lich_trinh_user',
                      arguments: {
                        'tourId': favorite.tourId,
                        'userId': favorite.userId,
                      },
                    );
                  },
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
