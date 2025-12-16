import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/data/request/user/read_review_requets.dart';
import 'package:booking_tour_flutter/domain/notification.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'thong_bao_state.dart';

class ThongBaoCubit extends Cubit<ThongBaoState> {
  static final BookingRepository _repository = getIt<BookingRepository>();

  ThongBaoCubit() : super(const ThongBaoState());

  Future<void> load(int userId) async {
    emit(state.copyWith(isLoading: true));

    final result = await _repository.getNotification(userId);
    result.fold((failure) => emit(state.copyWith(isLoading: false)), (items) {
      final notificationList = items.cast<Notification>();
      emit(
        state.copyWith(
          items: notificationList,
          filteredItems: notificationList,
          isLoading: false,
        ),
      );
    });
  }

  Future<void> readReview(int id, bool isRead) async {
    ReadReviewRequets readReviewRequets = ReadReviewRequets(
      id: id,
      isRead: isRead,
    );

    final result = await _repository.notifaiIsRead(readReviewRequets);
    result.fold((failure) => emit(state.copyWith(isLoading: false)), (items) {
      final updatedItems =
          state.items.map((notification) {
            if (notification.id == id) {
              return notification.copyWith(isRead: isRead);
            }
            return notification;
          }).toList();

      final updatedFilteredItems =
          state.filteredItems.map((notification) {
            if (notification.id == id) {
              return notification.copyWith(isRead: isRead);
            }
            return notification;
          }).toList();

      emit(
        state.copyWith(
          items: updatedItems,
          filteredItems: updatedFilteredItems,
          isLoading: false,
        ),
      );
    });
  }

  void search(String query) {
    final lowerQuery = query.toLowerCase().trim();

    if (lowerQuery.isEmpty) {
      emit(state.copyWith(filteredItems: state.items, searchQuery: ''));
      return;
    }

    final filtered =
        state.items.where((notification) {
          return notification.content.toLowerCase().contains(lowerQuery);
        }).toList();

    emit(state.copyWith(filteredItems: filtered, searchQuery: query));
  }
}
