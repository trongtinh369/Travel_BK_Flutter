// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/booking_repository.dart' as _i249;
import '../../data/network/core_service.dart' as _i849;
import '../../data/network/dio/dio_manager.dart' as _i967;
import '../../presentation/tour_manager/lich_trinh/cubit/schedule_tourmanager_cubit.dart'
    as _i665;
import '../../presentation/tour_manager/lich_trinh/danh_sach_lich_trinh/cubit/schedule_tourmanager_cubit.dart'
    as _i590;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final dioManager = _$DioManager();
  gh.factory<_i361.Dio>(() => dioManager.createDio());
  gh.factory<_i849.CoreService>(() => _i849.CoreService(gh<_i361.Dio>()));
  gh.singleton<_i249.BookingRepository>(
    () => _i249.BookingRepositoryImp(gh<_i849.CoreService>()),
  );
  gh.factory<_i665.ScheduleTourmanagerCubit>(
    () => _i665.ScheduleTourmanagerCubit(gh<_i249.BookingRepository>()),
  );
  gh.factory<_i590.ScheduleTourmanagerCubit>(
    () => _i590.ScheduleTourmanagerCubit(gh<_i249.BookingRepository>()),
  );
  return getIt;
}

class _$DioManager extends _i967.DioManager {}
