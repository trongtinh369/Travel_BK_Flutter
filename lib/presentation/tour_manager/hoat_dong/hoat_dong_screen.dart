import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/domain/activity.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/hoat_dong/widget/dialog_hoat_dong.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/hoat_dong/cubit/hoat_dong_cubit.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/hoat_dong/cubit/hoat_dong_state.dart';
import 'package:booking_tour_flutter/presentation/widgets_v/drawer_bar/drawer_bar.dart';
import 'package:booking_tour_flutter/presentation/widgets/bk_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HoatDongScreen extends StatefulWidget {
  const HoatDongScreen({super.key});

  @override
  State<HoatDongScreen> createState() => _HoatDongScreenState();
}

class _HoatDongScreenState extends State<HoatDongScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final _cubit = HoatDongCubit();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit..loadActivities(),
      child: Scaffold(
        drawer: DrawerBar(),
        appBar: AppBar(
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu, color: AppColors.white),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          title: const Text(
            'Hoạt Động',
            style: TextStyle(color: AppColors.white),
          ),
          backgroundColor: AppColors.button,
          centerTitle: true,
        ),
        backgroundColor: AppColors.white,
        body: BlocConsumer<HoatDongCubit, HoatDongState>(
          listener: (context, state) {
            if (state is HoatDongSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
            }
            if (state is HoatDongError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                _focusNode.unfocus();
              },
              child: Container(
                color: AppColors.white,
                child: Column(
                  children: [
                    if (state is HoatDongLoading)
                      const LinearProgressIndicator(),
                    Expanded(
                      child: Container(
                        color: AppColors.secondary.withOpacity(0.2),
                        child: _buildActivitiesList(state),
                      ),
                    ),

                    Container(
                      color: AppColors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: BkButton(
                        onPressed: () => _showAddActivityDialog(context),
                        title: "Thêm",
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildActivitiesList(HoatDongState state) {
    if (state is HoatDongLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is HoatDongLoaded) {
      final activities = state.activities;

      if (activities.isEmpty) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.event_note, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'Không có hoạt động nào',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ],
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: () async {
          await _cubit.refreshActivities();
        },
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: activities.length,
          itemBuilder: (context, index) {
            final activity = activities[index];
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(color: AppColors.secondary.withOpacity(0.2)),
              ),
              child: ListTile(
                title: Text(
                  activity.action,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    switch (value) {
                      case 'edit':
                        _showEditActivityDialog(context, activity);
                        break;
                      case 'delete':
                        _showDeleteConfirmation(context, activity);
                        break;
                    }
                  },
                  itemBuilder:
                      (context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit),
                              SizedBox(width: 8),
                              Text('Sửa'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.red),
                              SizedBox(width: 8),
                              Text('Xóa', style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      ],
                ),
              ),
            );
          },
        ),
      );
    }

    if (state is HoatDongSuccess) {
      return _buildActivitiesList(HoatDongLoaded(activities: state.activities));
    }

    return const Center(child: Text('Không có dữ liệu'));
  }

  void _showAddActivityDialog(BuildContext context) {
    DialogHoatDong.show(
      context: context,
      title: "Thêm hoạt động",
      showInput: true,
      onConfirm: (text) {
        if (text.isNotEmpty) {
          context.read<HoatDongCubit>().addActivity(text);
        }
      },
    );
  }

  void _showEditActivityDialog(BuildContext context, Activity activity) {
    DialogHoatDong.show(
      context: context,
      title: "Sửa hoạt động",
      showInput: true,
      initialValue: activity.action,
      onConfirm: (text) {
        if (text.isNotEmpty && text != activity.action) {
          context.read<HoatDongCubit>().updateActivity(activity.id, text);
        }
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context, Activity activity) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Xác nhận xóa'),
            content: Text('Bạn có muốn xóa hoạt động ${activity.action}?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Hủy'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _cubit.deleteActivity(activity.id);
                },
                child: const Text('Xóa', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );
  }
}
