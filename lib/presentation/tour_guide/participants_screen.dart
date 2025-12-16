import 'package:booking_tour_flutter/presentation/tour_guide/cubit/participants_cubit.dart';
import 'package:booking_tour_flutter/presentation/tour_guide/cubit/participants_state.dart';
import 'package:booking_tour_flutter/presentation/tour_guide/participants_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/schedule_tourguide.dart';

class ParticipantsScreen extends StatelessWidget {
  final ScheduleTourguide schedule;

  const ParticipantsScreen({Key? key, required this.schedule}) : super(key: key);

  String _formatDate(DateTime d) {
    final two = (int n) => n.toString().padLeft(2, '0');
    return '${two(d.day)}/${two(d.month)}/${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ParticipantsCubit()
        ..loadParticipants(
          schedule.id, // Truyền ID của schedule
          schedule.idSchedule, // Mã schedule
          schedule.startDate,
          schedule.endDate,
        ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Danh sách người tham gia'),
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
        body: BlocBuilder<ParticipantsCubit, ParticipantsState>(
          builder: (context, state) {
            if (state is ParticipantsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ParticipantsError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      'Lỗi: ${state.message}',
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ParticipantsCubit>().loadParticipants(
                          schedule.id,
                          schedule.idSchedule,
                          schedule.startDate,
                          schedule.endDate,
                        );
                      },
                      child: const Text('Thử lại'),
                    ),
                  ],
                ),
              );
            }

            if (state is ParticipantsLoaded) {
              if (state.participants.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.people_outline, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      const Text(
                        'Chưa có người tham gia',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Mã: ${state.scheduleCode}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${_formatDate(state.startDate)} - ${_formatDate(state.endDate)}',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Mã: ${state.scheduleCode}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${_formatDate(state.startDate)} - ${_formatDate(state.endDate)}',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tổng số người: ${state.participants.length}',
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.participants.length,
                      itemBuilder: (context, index) {
                        return ParticipantCard(participant: state.participants[index]);
                      },
                    ),
                  ),
                ],
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}