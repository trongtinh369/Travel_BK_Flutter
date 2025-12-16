class TourOption {
  final int id;
  final String title;
  final int price;
  final int percentDeposit;

  const TourOption({
    required this.id,
    required this.title,
    required this.price,
    required this.percentDeposit,
  });

  static List<TourOption> fromTrips(List trips) {
    return trips
        .map((t) {
          final id = t.id;
          final title = t.title ?? '';
          final price = t.price ?? 0;
          final percentDeposit = t.percentDeposit ?? 0;
          if (id != null && title.isNotEmpty) {
            return TourOption(
              id: id,
              title: title,
              price: price,
              percentDeposit: percentDeposit,
            );
          }
          return null;
        })
        .whereType<TourOption>()
        .toList();
  }
}
