import 'package:booking_tour_flutter/domain/notification.dart';

class ThongBaoState {
  final List<Notification> items;
  final List<Notification> filteredItems;
  final bool isLoading;
  final String searchQuery;

  const ThongBaoState({
    this.items = const [],
    this.filteredItems = const [],
    this.isLoading = true,
    this.searchQuery = '',
  });

  ThongBaoState copyWith({
    List<Notification>? items,
    List<Notification>? filteredItems,
    bool? isLoading,
    String? searchQuery,
  }) {
    return ThongBaoState(
      items: items ?? this.items,
      filteredItems: filteredItems ?? this.filteredItems,
      isLoading: isLoading ?? this.isLoading,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
