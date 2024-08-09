// Event
import 'package:equatable/equatable.dart';

abstract class ChartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SubscribeStreamEvent extends ChartEvent {}

class UpdateChartDataEvent extends ChartEvent {
  final ChartData data;

  UpdateChartDataEvent(this.data);

  @override
  List<Object> get props => [data];
}

// State
abstract class ChartState extends Equatable {
  @override
  List<Object> get props => [];
}

class ChartInitial extends ChartState {}

class ChartDataUpdated extends ChartState {
  final List<ChartData> data;

  ChartDataUpdated(this.data);

  @override
  List<Object> get props => [data];
}

// Data Model
class ChartData {
  final String symbol;
  final double price;
  final double quantity;
  final double priceChange;
  final double priceChangePercent;
  final double time;

  ChartData({
    required this.symbol,
    required this.price,
    required this.quantity,
    required this.priceChange,
    required this.priceChangePercent,
    required this.time,
  });

  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(
      symbol: json['s'] ?? '',
      price: double.parse(json['p'] ?? '0'),
      quantity: double.parse(json['q'] ?? '0'),
      priceChange: double.parse(json['dc'] ?? '0'),
      priceChangePercent: double.parse(json['dd'] ?? '0'),
      time: double.parse((json['t'] ?? '0').toString()),
    );
  }
}
