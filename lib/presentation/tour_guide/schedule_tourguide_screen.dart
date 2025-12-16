import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/presentation/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:booking_tour_flutter/presentation/tour_guide/cubit/schedule_tourguide_cubit.dart';
import 'package:booking_tour_flutter/presentation/tour_guide/cubit/schedule_tourguide_sate.dart';
import 'package:booking_tour_flutter/presentation/tour_guide/schedule_tourguide_card.dart';
import 'package:booking_tour_flutter/presentation/tour_guide/participants_screen.dart';

class ScheduleTourguideScreen extends StatelessWidget {
  const ScheduleTourguideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lấy AuthCubit từ context
    final authCubit = context.read<AuthCubit>();
  

    return BlocProvider(
      create: (_) => ScheduleTourguideCubit(
        authCubit: authCubit,
        bookingRepository: getIt(),
      )..loadSchedules(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Danh sách lịch trình'),
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
        body: BlocBuilder<ScheduleTourguideCubit, ScheduleTourguideState>(
          builder: (context, state) {
            if (state is ScheduleTourguideLoaded) {
              if (state.schedules.isEmpty) {
                return const Center(child: Text('Không có lịch trình nào.'));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: state.schedules.length,
                itemBuilder: (context, index) {
                  final schedule = state.schedules[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ParticipantsScreen(schedule: schedule),
                        ),
                      );
                    },
                    child: ScheduleTourguideCard(
                      scheduleTourguide: schedule,
                    ),
                  );
                },
              );
            }

            if (state is ScheduleTourguideError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Lỗi: ${state.message}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ScheduleTourguideCubit>().loadSchedules();
                      },
                      child: const Text('Thử lại'),
                    ),
                  ],
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}