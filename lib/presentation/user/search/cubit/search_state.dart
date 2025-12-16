import '../../../../domain/trip.dart';
abstract class SearchState {}

class SearchInitial extends SearchState {
  final List<String> history;
  SearchInitial({this.history = const []});
}

class SearchLoading extends SearchState {
  final List<String> history;
  SearchLoading({this.history = const []});
}

class SearchLoaded extends SearchState {
  final List<Trip> trips;
  final List<String> history;
  SearchLoaded(this.trips, {this.history = const []});
}

class SearchError extends SearchState {
  final String message;
  final List<String> history;
  SearchError(this.message, {this.history = const []});
}
