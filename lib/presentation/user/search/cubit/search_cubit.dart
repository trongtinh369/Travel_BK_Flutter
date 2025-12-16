

import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/presentation/user/search/cubit/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchCubit extends Cubit<SearchState> {
  final BookingRepository _repository = getIt<BookingRepository>();
  List<String> _history = [];
  String _currentQuery = '';
  int? provinceId;
  String? provinceName;
  DateTime? startDate;
  DateTime? endDate;
  int? stars;

  SearchCubit() : super(SearchInitial(history: [])) {
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    _history = prefs.getStringList('searchHistory') ?? [];
    emit(SearchInitial(history: _history));
  }

  Future<void> _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('searchHistory', _history);
  }

  Future<void> searchTrips(String query) async {
    final keyword = query.trim();
    _currentQuery = keyword;

    if (keyword.isEmpty && !hasActiveFilters) {
      emit(SearchInitial(history: _history));
      return;
    }

    if (keyword.isNotEmpty) {
      _addToHistory(keyword);
    }

    emit(SearchLoading(history: _history));

    final result = await _repository.getTrips(
      filter: keyword.isNotEmpty ? keyword : null,
      provinceId: provinceId,
      startDate: startDate,
      endDate: endDate,
      stars: stars,
    );

    result.fold(
      (failure) => emit(SearchError(failure.message, history: _history)),
      (trips) => emit(SearchLoaded(trips, history: _history)),
    );
  }
  void updateQuery(String query) {
    _currentQuery = query.trim();
  }

  void applyFilters({
    int? provinceId,
    String? provinceName,
    DateTime? startDate,
    DateTime? endDate,
    int? stars,
  }) {
    this.provinceId = provinceId;
    this.provinceName = provinceName;
    this.startDate = startDate;
    this.endDate = endDate;
    this.stars = stars;

    if (hasActiveFilters || _currentQuery.isNotEmpty) {
      searchTrips(_currentQuery);
    }
  }

  void clearFilters() {
    provinceId = null;
    provinceName = null;
    startDate = null;
    endDate = null;
    stars = null;
    searchTrips(_currentQuery);
  }

  bool get hasActiveFilters =>
      provinceId != null ||
      startDate != null ||
      endDate != null ||
      stars != null;
  String get currentQuery => _currentQuery;

  void reset() {
    _currentQuery = '';
    clearFilters();
    emit(SearchInitial(history: _history));
  }

  void _addToHistory(String keyword) {
    if (!_history.contains(keyword)) {
      _history.insert(0, keyword);
      if (_history.length > 10) {
        _history.removeLast();
      }
      _saveHistory();
    }
  }

  void removeFromHistory(String keyword) {
    _history.remove(keyword);
    _saveHistory();
    emit(SearchInitial(history: _history));
  }

  void clearHistory() {
    _history.clear();
    _saveHistory();
    emit(SearchInitial(history: _history));
  }
}