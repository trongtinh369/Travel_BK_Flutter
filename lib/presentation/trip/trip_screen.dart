import 'package:booking_tour_flutter/app/dialog_helper.dart';
import 'package:booking_tour_flutter/app/route_manager.dart';
import 'package:booking_tour_flutter/data/network/dio/failure.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/add_tour/cubit/add_tour_cubit.dart';
import 'package:booking_tour_flutter/presentation/trip/cubit/trip_bloc.dart';

import 'package:booking_tour_flutter/presentation/trip/cubit/trip_state.dart';
import 'package:booking_tour_flutter/presentation/trip/trip_card.dart';

import 'package:booking_tour_flutter/presentation/widgets_v/drawer_bar/drawer_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/add_tour/cubit/add_tour_state.dart';

class TripScreen extends StatelessWidget {
  final _cubit = TripCubit()..loadTrips();

  TripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _cubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Quản lý chuyến đi'),
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          leading: Builder(
            builder:
                (context) => IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
          ),
        ),
        drawer: DrawerBar(),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<TripCubit, TripState>(
                bloc: _cubit,
                builder: (context, state) {
                  if (state is TripLoaded) {
                    return ListView(
                      padding: EdgeInsets.all(8),
                      children:
                          state.trips.map((trip) {
                            return TripCard(
                              trip: trip,
                              onDelete: () async {
                                final confirmed =
                                    await DialogHelper.showConfirmDialog(
                                      body: Text(
                                        'Bạn có chắc muốn xóa chuyến đi này?',
                                      ),
                                    );

                                if (!confirmed) return;
                                await DialogHelper.showLoadingDialog();

                                final Either<Failure, void> result =
                                    await _cubit.deleteTrip(trip);
                                DialogHelper.dismissDialog();

                                result.fold((failure) async {
                                  await DialogHelper.showInformDialog(
                                    Text(
                                      'Bạn không thể xóa tour này!',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                }, (_) {});
                              },
                              onView: () async {
                                context.read<AddTourCubit>().setState(
                                  trip.toAddTourState(),
                                );
                                await Navigator.pushNamed(
                                  context,
                                  RouteName.updateTour,
                                );
                                _cubit.loadTrips();
                              },
                            );
                          }).toList(),
                    );
                  }

                  if (state is TripError) {
                    return Center(child: Text('Lỗi: ${state.message}'));
                  }

                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border(
                  top: BorderSide(color: Colors.grey[100]!, width: 1),
                ),
              ),
              child: ElevatedButton.icon(
                onPressed: () async {
                  await Navigator.pushNamed(context, RouteName.addTour);
                  _cubit.loadTrips();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: Icon(Icons.add),
                label: Text(
                  'Thêm Chuyến đi',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
