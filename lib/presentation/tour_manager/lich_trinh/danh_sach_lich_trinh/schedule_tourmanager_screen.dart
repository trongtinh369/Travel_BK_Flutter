import 'package:booking_tour_flutter/app/dialog_helper.dart';
import 'package:booking_tour_flutter/app/route_manager.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/lich_trinh/danh_sach_lich_trinh/cubit/schedule_tourmanager_cubit.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/lich_trinh/danh_sach_lich_trinh/cubit/schedule_tourmanager_state.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/lich_trinh/danh_sach_lich_trinh/schedule_tourmanager_card.dart';
import 'package:booking_tour_flutter/presentation/widgets_dialog/dialog_noti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:booking_tour_flutter/presentation/widgets_v/drawer_bar/drawer_bar.dart';

class ScheduleTourmanagerScreen extends StatelessWidget {
  const ScheduleTourmanagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              ScheduleTourmanagerCubit(GetIt.I<BookingRepository>())
                ..loadSchedules(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lịch Trình'),
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
        drawer: DrawerBar(),
        body: BlocListener<ScheduleTourmanagerCubit, ScheduleTourmanagerState>(
          listener: (context, state) {
            if (state is ScheduleTourmanagerError) {
              DialogHelper.showInformDialog(
                Text(state.message, style: const TextStyle(color: Colors.red)),
              );
            }
          },
          child: BlocBuilder<
            ScheduleTourmanagerCubit,
            ScheduleTourmanagerState
          >(
            builder: (context, state) {
              if (state is ScheduleTourmanagerLoaded) {
                if (state.schedules.isEmpty) {
                  return const Center(child: Text('Chưa có lịch trình nào.'));
                }
                return ListView(
                  children:
                      state.schedules
                          .map(
                            (schedule) => ScheduleTourmanagerCard(
                              shedule_tour_manager: schedule,
                              onDelete: () async {
                                final confirmed = await DialogNoti.confirm(
                                  context: context,
                                  title: 'Xác nhận xóa',
                                  message:
                                      'Bạn có chắc muốn xóa lịch trình này?',
                                  highlightPhrases: ['xóa'],
                                );
                                if (confirmed) {
                                  context
                                      .read<ScheduleTourmanagerCubit>()
                                      .deleteSchedule(schedule);
                                }
                              },
                            ),
                          )
                          .toList(),
                );
              }

              if (state is ScheduleTourmanagerLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return const Center(child: Text('Đang tải dữ liệu...'));
            },
          ),
        ),
        floatingActionButton: Builder(
          builder:
              (btnContext) => FloatingActionButton.extended(
                onPressed: () async {
                  final cubit = btnContext.read<ScheduleTourmanagerCubit>();
                  final result = await cubit.getTours();
                  result.fold(
                    (failure) {
                      DialogHelper.showInformDialog(
                        Text(
                          'Lỗi : Bạn không thể xóa lịch trình này',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                    (trips) {
                      Navigator.pushNamed(
                        btnContext,
                        RouteName.themLichTrinh,
                        arguments: trips,
                      );
                    },
                  );
                },
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                icon: const Icon(Icons.add),
                label: const Text('Thêm'),
              ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
