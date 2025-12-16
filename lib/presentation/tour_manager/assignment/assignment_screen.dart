import 'package:booking_tour_flutter/app/dialog_helper.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/assignment/assignment_card.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/assignment/cubit/assignment_cubit.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/assignment/cubit/assignment_state.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/schedule_assignment/cubit/schedule_assignment_cubit.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/schedule_assignment/schedule_assignment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booking_tour_flutter/presentation/widgets_v/drawer_bar/drawer_bar.dart';

class AssignmentScreen extends StatelessWidget {
  const AssignmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = AssignmentCubit()..loadAssignments();

    return BlocProvider(
      create: (_) => cubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Phân công'),
          backgroundColor: Color(0xFF23A892),
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
        body: BlocBuilder<AssignmentCubit, AssignmentState>(
          builder: (context, state) {
            if (state is AssignmentLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is AssignmentError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 60, color: Colors.red),
                    SizedBox(height: 16),
                    Text(
                      'Lỗi: ${state.message}',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        cubit.loadAssignments();
                      },
                      child: Text('Thử lại'),
                    ),
                  ],
                ),
              );
            }

            if (state is AssignmentLoaded) {
              if (state.assignments.isEmpty) {
                return Center(
                  child: Text(
                    'Chưa có phân công nào',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              }

              return ListView.builder(
                itemCount: state.assignments.length,
                itemBuilder: (context, index) {
                  final assignment = state.assignments[index];
                  return AssignmentCard(
                    assignment: assignment,
                    onViewDetails: () async {
                      var cubit = context.read<ScheduleAssignmentCubit>();

                      cubit.setTourId(tourId: assignment.id);

                      await cubit.loadData();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScheduleAssignmentScreen(),
                        ),
                      );
                    },
                  );
                },
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
