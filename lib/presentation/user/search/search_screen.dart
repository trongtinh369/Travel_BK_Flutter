import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/presentation/user/search/cubit/search_cubit.dart';
import 'package:booking_tour_flutter/presentation/user/search/cubit/search_state.dart';
import 'package:booking_tour_flutter/presentation/user/search/search_card.dart';
import 'package:booking_tour_flutter/presentation/widgets/filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showFilterBottomSheet(BuildContext context, SearchCubit cubit) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => FilterBottomSheet(
            initialProvinceId: cubit.provinceId,
            initialProvinceName: cubit.provinceName,
            initialStartDate: cubit.startDate,
            initialEndDate: cubit.endDate,
            initialStars: cubit.stars,
          ),
    );

    if (result != null) {
      cubit.applyFilters(
        provinceId: result['provinceId'],
        provinceName: result['provinceName'],
        startDate: result['startDate'],
        endDate: result['endDate'],
        stars: result['stars'],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(),
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          final cubit = context.read<SearchCubit>();

          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.white,
              leading: IconButton(
                color: AppColors.black,
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              title: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Nhập tên địa điểm...',
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 210, 209, 209),
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  fillColor: AppColors.white,
                ),
                onSubmitted:
                    (_) => cubit.searchTrips(_searchController.text.trim()),
                textInputAction: TextInputAction.search,
              ),

              actions: [
                Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.filter_alt_outlined),
                      color: AppColors.black,
                      onPressed: () => _showFilterBottomSheet(context, cubit),
                    ),
                    if (cubit.hasActiveFilters)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            body: Column(
              children: [
                if (cubit.hasActiveFilters) _buildActiveFiltersChips(cubit),
                Expanded(child: _buildBody(context, state, cubit)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildActiveFiltersChips(SearchCubit cubit) {
    final chips = <Widget>[];
    if (cubit.provinceId != null && cubit.provinceName != null) {
      chips.add(
        _buildFilterChip(
          label: cubit.provinceName!,
          onDeleted: () {
            cubit.applyFilters(
              provinceId: null,
              provinceName: null,
              startDate: cubit.startDate,
              endDate: cubit.endDate,
              stars: cubit.stars,
            );
          },
        ),
      );
    }
    if (cubit.startDate != null && cubit.endDate != null) {
      final dateText =
          '${_formatDate(cubit.startDate!)} - ${_formatDate(cubit.endDate!)}';
      chips.add(
        _buildFilterChip(
          label: dateText,
          onDeleted: () {
            cubit.applyFilters(
              provinceId: cubit.provinceId,
              provinceName: cubit.provinceName,
              startDate: null,
              endDate: null,
              stars: cubit.stars,
            );
          },
        ),
      );
    }
    if (cubit.stars != null) {
      chips.add(
        _buildFilterChip(
          label: '${cubit.stars} ⭐',
          onDeleted: () {
            cubit.applyFilters(
              provinceId: cubit.provinceId,
              provinceName: cubit.provinceName,
              startDate: cubit.startDate,
              endDate: cubit.endDate,
              stars: null,
            );
          },
        ),
      );
    }

    if (chips.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey[100],
      child: Row(
        children: [
          Expanded(child: Wrap(spacing: 8, runSpacing: 8, children: chips)),
          TextButton(
            onPressed: () => cubit.clearFilters(),
            child: const Text('Xóa tất cả'),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required VoidCallback onDeleted,
  }) {
    return Chip(
      label: Text(label),
      deleteIcon: const Icon(Icons.close, size: 18),
      onDeleted: onDeleted,
      backgroundColor: Colors.teal[50],
      labelStyle: const TextStyle(fontSize: 12),
      visualDensity: VisualDensity.compact,
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  Widget _buildBody(
    BuildContext context,
    SearchState state,
    SearchCubit cubit,
  ) {
    if (state is SearchInitial) {
      if (state.history.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search, size: 80, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                'Nhập từ khóa để tìm kiếm tour',
                style: TextStyle(
                  fontSize: 16,
                  color: const Color.fromARGB(255, 69, 69, 69),
                ),
              ),
            ],
          ),
        );
      } else {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Lịch sử tìm kiếm',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...state.history.map(
              (keyword) => ListTile( 
                
                leading: const Icon(Icons.history),
                title: Text(keyword),
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => cubit.removeFromHistory(keyword),
                ),
                onTap: () {
                  _searchController.text = keyword;
                  cubit.searchTrips(keyword);
                },
              ),
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: cubit.clearHistory,
              icon: const Icon(Icons.delete_forever, color: AppColors.delete),
              label: const Text('Xóa toàn bộ lịch sử'),
            ),
          ],
        );
      }
    }

    if (state is SearchLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is SearchError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 80, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text(
              state.message,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => cubit.searchTrips(_searchController.text.trim()),
              icon: const Icon(Icons.refresh),
              label: const Text('Thử lại'),
            ),
          ],
        ),
      );
    }

    if (state is SearchLoaded) {
      final trips = state.trips;

      if (trips.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off, size: 80, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                'Không tìm thấy kết quả',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 8),
              Text(
                'Thử với từ khóa khác hoặc điều chỉnh bộ lọc',
                style: TextStyle(fontSize: 14, color: Colors.grey[500]),
              ),
            ],
          ),
        );
      }

      return Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            width: double.infinity,
            color: Colors.grey[100],
            child: Text(
              'Tìm thấy ${trips.length} kết quả',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: trips.length,
              itemBuilder: (context, index) {
                final trip = trips[index];
                return SearchCard(
                  trip: trip,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      'danh_sach_lich_trinh_user',
                      arguments: {'tourId': trip.id},
                    );
                  },
                );
              },
            ),
          ),
        ],
      );
    }

    return const SizedBox();
  }
}
