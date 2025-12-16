import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/presentation/admin/income_statistics/cubit/income_statistic_cubit.dart';
import 'package:booking_tour_flutter/presentation/admin/income_statistics/income_statistics_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'cubit/income_statistic_state.dart';

class IncomeStatisticScreen extends StatefulWidget {
  const IncomeStatisticScreen({super.key});

  @override
  State<IncomeStatisticScreen> createState() => _IncomeStatisticScreenState();
}

class _IncomeStatisticScreenState extends State<IncomeStatisticScreen> {
  bool isMonthView = true;

  @override
  void initState() {
    super.initState();
    context.read<IncomeCubit>().loadIncomeByMonth();
  }

  void _switchToMonth() {
    if (!isMonthView) {
      setState(() => isMonthView = true);
      context.read<IncomeCubit>().loadIncomeByMonth();
    }
  }

  void _switchToYear() {
    if (isMonthView) {
      setState(() => isMonthView = false);
      context.read<IncomeCubit>().loadIncomeByYear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocBuilder<IncomeCubit, IncomeStatisticState>(
        builder: (context, state) {
          if (state is IncomeStatisticLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.backgroundAppBarTheme,
              ),
            );
          }

          if (state is IncomeStatisticError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 60,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (isMonthView) {
                        context.read<IncomeCubit>().loadIncomeByMonth();
                      } else {
                        context.read<IncomeCubit>().loadIncomeByYear();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.backgroundAppBarTheme,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Thử lại'),
                  ),
                ],
              ),
            );
          }

          if (state is IncomeStatisticLoaded) {
            return SafeArea(
              child: Column(
                children: [
                  // Header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    color: AppColors.backgroundAppBarTheme,
                    child: const Center(
                      child: Text(
                        "Thống kê thu nhập",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  // Scrollable content
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),

                          // Total Income Card
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                vertical: 24,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 2),
                                    blurRadius: 8,
                                    color: Colors.black.withOpacity(0.1),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  const Text(
                                    "TỔNG THU NHẬP",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    "${NumberFormat.decimalPattern().format(state.totalIcome)} VND",
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Month/Year Toggle
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: _switchToMonth,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 24,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isMonthView
                                          ? Colors.white
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: isMonthView
                                            ? AppColors.backgroundAppBarTheme
                                            : Colors.transparent,
                                        width: 2,
                                      ),
                                    ),
                                    child: Text(
                                      "Theo tháng",
                                      style: TextStyle(
                                        color: isMonthView
                                            ? AppColors.backgroundAppBarTheme
                                            : Colors.grey,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                GestureDetector(
                                  onTap: _switchToYear,
                                  child: Text(
                                    "Theo năm",
                                    style: TextStyle(
                                      color: !isMonthView
                                          ? AppColors.backgroundAppBarTheme
                                          : Colors.grey,
                                      fontWeight: !isMonthView
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Chart Title and Year
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Biểu đồ thu nhập",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                if (isMonthView)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6,
                                      horizontal: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Text(
                                      "2025",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Bar Chart
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Builder(
                                builder: (context) {
                                  final maxIncome = state.months.isEmpty
                                      ? 0.0
                                      : state.months.reduce(
                                            (a, b) => a > b ? a : b,
                                          ) /
                                          1000000;
                                  final maxY = maxIncome == 0 
                                      ? 10.0 
                                      : (maxIncome * 1.2).ceilToDouble();
                                  final interval = maxY / 8;

                                  return BarChart(
                                    BarChartData(
                                      maxY: maxY,
                                      borderData: FlBorderData(show: false),
                                      gridData: FlGridData(
                                        show: true,
                                        drawVerticalLine: false,
                                        horizontalInterval: interval,
                                        getDrawingHorizontalLine: (value) {
                                          return FlLine(
                                            color: Colors.grey[300],
                                            strokeWidth: 1,
                                          );
                                        },
                                      ),
                                      titlesData: FlTitlesData(
                                        leftTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: true,
                                            reservedSize: 35,
                                            interval: interval,
                                            getTitlesWidget: (value, meta) {
                                              return Text(
                                                "${value.toInt()}M",
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.grey[600],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        rightTitles: AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false),
                                        ),
                                        topTitles: AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false),
                                        ),
                                        bottomTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: true,
                                            getTitlesWidget: (value, meta) {
                                              final index = value.toInt();
                                              if (isMonthView && index < 12) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8),
                                                  child: Text(
                                                    "T${index + 1}",
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.grey[600],
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                );
                                              } else if (!isMonthView &&
                                                  state.years != null &&
                                                  index < state.years!.length) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8),
                                                  child: Text(
                                                    state.years![index],
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.grey[600],
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                );
                                              }
                                              return const SizedBox();
                                            },
                                          ),
                                        ),
                                      ),
                                      barGroups: List.generate(
                                          state.months.length, (i) {
                                        final vnd = state.months[i] / 1000000;
                                        return BarChartGroupData(
                                          x: i,
                                          barRods: [
                                            BarChartRodData(
                                              toY: vnd.toDouble(),
                                              width: 20,
                                              color: Colors.green,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(6),
                                                topRight: Radius.circular(6),
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Summary Cards
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: IncomeSummaryCard(
                                    title: isMonthView
                                        ? "Trung bình / tháng"
                                        : "Trung bình / năm",
                                    value:
                                        "${NumberFormat.decimalPattern().format(state.average)} VND",
                                    icon: Icons.leaderboard,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: IncomeSummaryCard(
                                    title: "Cao nhất",
                                    value:
                                        "${NumberFormat.decimalPattern().format(state.highest)} VND",
                                    icon: Icons.stacked_line_chart,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(
            child: Text(
              "Có lỗi xảy ra",
              style: TextStyle(fontSize: 16),
            ),
          );
        },
      ),
    );
  }
}