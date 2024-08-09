// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:swo/modules/charting/charting.bloc.dart';
// import 'package:swo/modules/charting/charting.state.dart';
// import 'package:swo/utils/colors.dart';

// class ChartingModule extends StatefulWidget {
//   const ChartingModule({super.key});

//   @override
//   State<ChartingModule> createState() => _ChartingModuleState();
// }

// class _ChartingModuleState extends State<ChartingModule> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   List<Color> gradientColors = [
//     AppColors.contentColorCyan,
//     AppColors.contentColorBlue,
//   ];

//   Widget bottomTitleWidgets(double value, TitleMeta meta, List<ChartData> data) {
//     // Find the corresponding ChartData entry based on the x-axis value
//     final int index = value.toInt();

//     // Ensure the index is within the data range
//     if (index >= 0 && index < data.length) {
//       final chartData = data[index];

//       // Format the time for display (e.g., HH:mm)
//       final timeLabel = chartData.time.toString();

//       return Transform(
//         alignment: Alignment.center,
//         transform: Matrix4.rotationZ(1.5708),
//         child: SideTitleWidget(
//           axisSide: meta.axisSide,
//           space: 8.0, // Adds some space between the axis and the title
//           child: Padding(
//             padding: EdgeInsets.only(left: 100, bottom: 5),
//             child: Text(timeLabel),
//           ),
//         ),
//       );
//     }

//     return const SizedBox.shrink(); // Return an empty widget if no data
//   }

//   Widget leftTitleWidgets(double value, TitleMeta meta, List<ChartData> data) {
//     // Find the minimum and maximum y-values in the data
//     final minY = data.isNotEmpty ? data.map((e) => e.price).reduce((a, b) => a < b ? a : b) : 0;
//     final maxY = data.isNotEmpty ? data.map((e) => e.price).reduce((a, b) => a > b ? a : b) : 6;
//     // Map the value to the corresponding price
//     final priceRange = maxY - minY;
//     final mappedPrice = minY + (value / 6) * priceRange; // Adjust if maxY is different
//     return Text(mappedPrice.toStringAsFixed(2), textAlign: TextAlign.left);
//   }

//   LineChartData mainData(ChartState state) {
//     // Check if the state is ChartDataUpdated
//     if (state is ChartDataUpdated) {
//       // Convert ChartData to FlSpot
//       final spots = state.data.map((chartData) {
//         // Use millisecondsSinceEpoch for x-coordinate; adjust as needed
//         final x = chartData.time;
//         final y = chartData.price;
//         return FlSpot(x, y);
//       }).toList();

//       return LineChartData(
//         gridData: FlGridData(
//           show: true,
//           drawVerticalLine: true,
//           horizontalInterval: 1,
//           verticalInterval: 1,
//           getDrawingHorizontalLine: (value) {
//             return const FlLine(
//               color: Color.fromARGB(225, 3, 3, 3),
//               strokeWidth: 1,
//             );
//           },
//           getDrawingVerticalLine: (value) {
//             return const FlLine(
//               color: AppColors.mainGridLineColor,
//               strokeWidth: 1,
//             );
//           },
//         ),
//         titlesData: FlTitlesData(
//           show: true,
//           rightTitles: const AxisTitles(
//             sideTitles: SideTitles(showTitles: false),
//           ),
//           topTitles: const AxisTitles(
//             sideTitles: SideTitles(showTitles: false),
//           ),
//           bottomTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               reservedSize: 30,
//               interval: 1,
//               getTitlesWidget: (value, meta) => bottomTitleWidgets(value, meta, state.data),
//             ),
//           ),
//           leftTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               interval: 1,
//               getTitlesWidget: (value, meta) => leftTitleWidgets(value, meta, state.data),
//               reservedSize: 42,
//             ),
//           ),
//         ),
//         borderData: FlBorderData(
//           show: true,
//           border: Border.all(color: const Color(0xff37434d)),
//         ),
//         minX: 0,
//         maxX: 5,
//         minY: 0,
//         maxY: 10,
//         lineBarsData: [
//           LineChartBarData(
//             spots: spots, // Use the converted spots
//             isCurved: true,
//             gradient: LinearGradient(
//               colors: gradientColors,
//             ),
//             barWidth: 5,
//             isStrokeCapRound: true,
//             dotData: const FlDotData(
//               show: false,
//             ),
//             belowBarData: BarAreaData(
//               show: true,
//               gradient: LinearGradient(
//                 colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
//               ),
//             ),
//           ),
//         ],
//       );
//     }

//     // Return a default or empty chart if the state is not ChartDataUpdated
//     return LineChartData(
//       lineBarsData: [],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<ChartBloc>(
//       create: (context) => ChartBloc()..add(SubscribeStreamEvent()),
//       child: BlocBuilder<ChartBloc, ChartState>(
//         builder: (context, state) => Column(
//           children: [
//             AspectRatio(
//               aspectRatio: 1.70,
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                   right: 18,
//                   left: 12,
//                   top: 24,
//                   bottom: 12,
//                 ),
//                 child: LineChart(
//                   mainData(state),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
