// Event
import 'package:equatable/equatable.dart';

abstract class WatchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SubscribeStreamEvent extends WatchEvent {}

class UpdateWatchDataEvent extends WatchEvent {
  final WatchData data;

  UpdateWatchDataEvent(this.data);

  @override
  List<Object> get props => [data];
}

// State
abstract class WatchState extends Equatable {
  @override
  List<Object> get props => [];
}

class WatchInitial extends WatchState {}

class WatchDataUpdated extends WatchState {
  final List<WatchData> data;

  WatchDataUpdated(this.data);

  @override
  List<Object> get props => [data];
}

// Data Model
class WatchData {
  final String symbol;
  final double price;
  final double quantity;
  final double priceChange;
  final double priceChangePercent;
  final double time;

  WatchData({
    required this.symbol,
    required this.price,
    required this.quantity,
    required this.priceChange,
    required this.priceChangePercent,
    required this.time,
  });

  factory WatchData.fromJson(Map<String, dynamic> json) {
    return WatchData(
      symbol: json['s'] ?? '',
      price: double.parse(json['p'] ?? '0'),
      quantity: double.parse(json['q'] ?? '0'),
      priceChange: double.parse(json['dc'] ?? '0'),
      priceChangePercent: double.parse(json['dd'] ?? '0'),
      time: double.parse((json['t'] ?? '0').toString()),
    );
  }
}
