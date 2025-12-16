import 'package:booking_tour_flutter/presentation/accountant/accountant_manage_schedule/cubit/accountant_manage_schedule_cubit.dart';
import 'package:booking_tour_flutter/presentation/admin/account_management/cubit/account_management_cubit.dart';
import 'package:booking_tour_flutter/presentation/admin/create_staff_account/cubit/create_staff_account_part1_cubit.dart';
import 'package:booking_tour_flutter/presentation/admin/create_staff_account/cubit/create_staff_account_part2_cubit.dart';
import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/presentation/admin/income_statistics/cubit/income_statistic_cubit.dart';
import 'package:booking_tour_flutter/presentation/admin/schedulereviewdetail/cubit/schedule_review_detail_cubit.dart';
import 'package:booking_tour_flutter/presentation/admin/tourguide_rating/cubit/tourguide_rating_cubit.dart';
import 'package:booking_tour_flutter/presentation/auth/auth_cubit.dart';
import 'package:booking_tour_flutter/presentation/auth/auth_otp/cubit/auth_otp_cubit.dart';
import 'package:booking_tour_flutter/presentation/auth/auth_otp_change_password/cubit/auth_otp_change_password_cubit.dart';
import 'package:booking_tour_flutter/presentation/auth/change_password/cubit/change_password_cubit.dart';
import 'package:booking_tour_flutter/presentation/profile/change_schedule/cubit/change_schedule_cubit.dart';
import 'package:booking_tour_flutter/presentation/profile/detail_paid_schedule/cubit/detail_paid_schedule_cubit.dart';
import 'package:booking_tour_flutter/presentation/profile/review_schedule/cubit/review_schedule_cubit.dart';
import 'package:booking_tour_flutter/presentation/reception/kiem_tra_nguoi_tham_gia/cubit/kiem_tra_nguoi_tham_gia_cubit.dart';
import 'package:booking_tour_flutter/presentation/reception/lich_trinh_chua_hoan_thanh/cubit/lich_trinh_chua_hoan_thanh_cubit.dart';
import 'package:booking_tour_flutter/presentation/reception/xac_nhan_so_nguoi_tham_gia/cubit/xac_nhan_so_nguoi_tham_gia_cubit.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/schedule_assignment/cubit/schedule_assignment_cubit.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/tour_guide_assignment/cubit/tour_guide_assignment_cubit.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/add_tour/cubit/add_tour_cubit.dart';
import 'package:booking_tour_flutter/presentation/user/book_a_schedule/cubit/book_schedule_cubit.dart';
import 'package:booking_tour_flutter/presentation/user/danh_sach_lich_trinh_booking/cubit/danh_sach_lich_trinh_booking_cubit.dart';
import 'package:booking_tour_flutter/presentation/user/favorite/cubit/favorite_cubit.dart';
import 'package:booking_tour_flutter/presentation/user/pay/cubit/pay_schedule_cubit.dart';
import 'package:booking_tour_flutter/presentation/user/schedule_detail/cubit/schedule_detail_cubit.dart';
import 'package:booking_tour_flutter/presentation/user/thong_bao/cubit/thong_bao_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppGlobalProvider extends StatelessWidget {
  final Widget child;

  const AppGlobalProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthOtpChangePasswordCubit()),
        BlocProvider(create: (_) => ChangePasswordCubit()),
        BlocProvider(create: (_) => AuthOtpCubit()),
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => AddTourCubit()),
        BlocProvider(create: (_) => TourGuideAssignmentCubit()),
        BlocProvider(create: (_) => ScheduleAssignmentCubit()),
        BlocProvider(create: (_) => ChangeScheduleCubit()),
        BlocProvider(create: (_) => PayScheduleCubit()),
        BlocProvider(create: (_) => ScheduleDetailCubit()),
        BlocProvider(create: (_) => BookScheduleCubit()),
        BlocProvider(create: (_) => ReviewScheduleCubit()),
        BlocProvider(create: (_) => DetailPaidScheduleCubit()),
        BlocProvider(create: (_) => DanhSachLichTrinhBookingCubit()),
        BlocProvider(create: (_) => ThongBaoCubit()),
        BlocProvider(create: (_) => XacNhanSoNguoiThamGiaCubit()),
        BlocProvider(create: (_) => KiemTraNguoiThamGiaCubit()),
        BlocProvider(create: (_) => AccountManagementCubit()),
        BlocProvider(create: (_) => CreateStaffAccountPart1Cubit()),
        BlocProvider(create: (_) => CreateStaffAccountPart2Cubit()),
        BlocProvider(create: (_) => IncomeCubit(getIt<BookingRepository>())),
        BlocProvider(create: (_) => AccountantManageScheduleCubit()),
        BlocProvider(create: (_) => FavoriteCubit()),
      ],

      child: child,
    );
  }
}
