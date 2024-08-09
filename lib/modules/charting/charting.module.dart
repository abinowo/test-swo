import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:swo/modules/charting/charting.bloc.dart';
import 'package:swo/modules/charting/charting.state.dart';
import 'package:swo/utils/colors.dart';

class ChartingModule extends StatefulWidget {
  const ChartingModule({super.key});

  @override
  State<ChartingModule> createState() => _ChartingModuleState();
}

class _ChartingModuleState extends State<ChartingModule> {
  @override
  void initState() {
    super.initState();
  }

  List<Color> gradientColors = [
    AppColors.contentColorCyan,
    AppColors.contentColorBlue,
  ];

  String formatTimestamp(int timestamp) {
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final String formattedTime = DateFormat('HH:mm:ss').format(dateTime);
    return formattedTime;
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta, List<ChartData> data) {
    return Text(formatTimestamp(value.toInt()));
  }

  Widget leftTitleWidgets(double value, TitleMeta meta, List<ChartData> data) {
    return Text(value.toStringAsFixed(0), textAlign: TextAlign.left);
  }

  LineChartData mainData(ChartState state) {
    // Check if the state is ChartDataUpdated
    if (state is ChartDataUpdated) {
      // Convert ChartData to FlSpot
      final spots = state.data.map((chartData) {
        // Use millisecondsSinceEpoch for x-coordinate; adjust as needed
        final x = chartData.time;
        final y = chartData.price;
        return FlSpot(x, y);
      }).toList();

      // loading
      if (spots.first.x < 1) {
        return LineChartData(
          lineBarsData: [],
        );
      }

      return LineChartData(
        gridData: FlGridData(
          show: false,
          drawVerticalLine: true,
          horizontalInterval: 1,
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return const FlLine(
              color: Color.fromARGB(225, 3, 3, 3),
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return const FlLine(
              color: AppColors.mainGridLineColor,
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 50,
              interval: 1000,
              getTitlesWidget: (value, meta) => bottomTitleWidgets(value, meta, state.data),
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, meta) => leftTitleWidgets(value, meta, state.data),
              reservedSize: 40,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d)),
        ),
        minY: spots.first.y - 5, // harus sama dengan data pertama dan dikurangi 5 sesuai dengan interval
        maxY: spots.last.y + 5, // harus sama dengan data terakhir dan ditambah 5 sesuai dengan interval
        minX: spots.first.x, // harus sama dengan data pertama supaya tidak terlalu jauh
        maxX: spots.last.x, // harus sama dengan data terakhir supaya tidak terlalu jauh
        lineBarsData: [
          LineChartBarData(
            spots: spots, // Use the converted spots
            isCurved: true,
            gradient: LinearGradient(
              colors: gradientColors,
            ),
            barWidth: 5,
            isStrokeCapRound: true,
            dotData: const FlDotData(
              show: false,
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
              ),
            ),
          ),
        ],
      );
    }

    // Return a default or empty chart if the state is not ChartDataUpdated
    return LineChartData(
      lineBarsData: [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChartBloc>(
      create: (context) => ChartBloc()..add(SubscribeStreamEvent()),
      child: BlocBuilder<ChartBloc, ChartState>(
        builder: (context, state) => Column(
          children: [
            AspectRatio(
              aspectRatio: 1.70,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 18,
                  left: 12,
                  top: 24,
                  bottom: 12,
                ),
                child: LineChart(
                  mainData(state),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
