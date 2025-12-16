import 'dart:io';

import 'package:booking_tour_flutter/app/app_navigator.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/route_manager.dart';
import 'package:booking_tour_flutter/presentation/admin/account_management/cubit/account_management_cubit.dart';
import 'package:booking_tour_flutter/presentation/widgets/bk_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'cubit/create_staff_account_part1_cubit.dart';
import 'cubit/create_staff_account_part2_cubit.dart';
import 'cubit/create_staff_account_part2_state.dart';

class CreateStaffAccountPart2Screen extends StatefulWidget {
  const CreateStaffAccountPart2Screen({super.key});

  @override
  State<CreateStaffAccountPart2Screen> createState() =>
      _CreateStaffAccountPart2ScreenState();
}

class _CreateStaffAccountPart2ScreenState
    extends State<CreateStaffAccountPart2Screen> {
  void _showOptions(BuildContext context, {required bool isFront}) {
    showModalBottomSheet(
      context: context,
      builder:
          (_) => SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Chụp ảnh'),
                  onTap: () {
                    Navigator.of(context).pop();
                    context.read<CreateStaffAccountPart2Cubit>().pickImage(
                      ImageSource.camera,
                      isFront: isFront,
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Chọn từ thư viện'),
                  onTap: () {
                    Navigator.of(context).pop();
                    context.read<CreateStaffAccountPart2Cubit>().pickImage(
                      ImageSource.gallery,
                      isFront: isFront,
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.close),
                  title: const Text('Huỷ'),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
    );
  }

  Widget _imageSlot({
    required BuildContext context,
    required String label,
    required String? path,
    required bool isFront,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _showOptions(context, isFront: isFront),
          behavior: HitTestBehavior.opaque,
          child: Stack(
            children: [
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                clipBehavior: Clip.hardEdge,
                child:
                    path == null
                        ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.add_circle_outline,
                                size: 34,
                                color: AppColors.gray,
                              ),
                              SizedBox(height: 6),
                              Text(
                                'Thêm ảnh',
                                style: TextStyle(color: AppColors.gray),
                              ),
                            ],
                          ),
                        )
                        : Image.file(
                          File(path),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
              ),
              if (path != null)
                Positioned(
                  right: 6,
                  top: 6,
                  child: GestureDetector(
                    onTap: () {
                      context.read<CreateStaffAccountPart2Cubit>().removeImage(
                        isFront: isFront,
                      );
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(4),
                      child: const Icon(
                        Icons.close,
                        size: 18,
                        color: AppColors.gray,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      CreateStaffAccountPart2Cubit,
      CreateStaffAccountPart2State
    >(
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: AppColors.white,
              appBar: AppBar(
                backgroundColor: AppColors.backgroundAppBarTheme,
                leading: const BackButton(color: AppColors.white),
                title: const Text('Thêm ảnh CCCD trước/ sau'),
                centerTitle: true,
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 18,
                  ),
                  child: Column(
                    children: [
                      _imageSlot(
                        context: context,
                        label: 'Mặt trước CCCD',
                        path: state.frontPath,
                        isFront: true,
                      ),
                      const SizedBox(height: 18),
                      _imageSlot(
                        context: context,
                        label: 'Mặt sau CCCD',
                        path: state.backPath,
                        isFront: false,
                      ),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: BkButton(
                          title: 'Xác nhận',
                          backgroundColor:
                              state.submitting
                                  ? AppColors.backgroundDisable
                                  : AppColors.backgroundAppBarTheme,
                          onPressed:
                              state.submitting
                                  ? () {}
                                  : () async {
                                    final part1Cubit =
                                        context
                                            .read<
                                              CreateStaffAccountPart1Cubit
                                            >();
                                    final part2Cubit =
                                        context
                                            .read<
                                              CreateStaffAccountPart2Cubit
                                            >();

                                    if (part2Cubit.state.submitting) return;

                                    final navigator = Navigator.of(context);
                                    final messenger = ScaffoldMessenger.of(
                                      context,
                                    );

                                    final success = await part2Cubit
                                        .createStaff(part1Cubit.state);

                                    if (!mounted) return;

                                    if (success) {
                                      part1Cubit.reset();
                                      part2Cubit.reset();

                                      messenger.showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Tạo tài khoản thành công',
                                          ),
                                        ),
                                      );
                                      navigator.pushNamedAndRemoveUntil(
                                        RouteName.mainAdminScreen,
                                        (route) => false,
                                        arguments: 1,
                                      );
                                      AppNavigator.currentContext
                                          .read<AccountManagementCubit>()
                                          .loadAll();
                                    } else {
                                      messenger.showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Tạo tài khoản thất bại, vui lòng thử lại',
                                          ),
                                        ),
                                      );
                                    }
                                  },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
