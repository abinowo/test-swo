import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swo/modules/charting/charting.state.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:async';

// Bloc
class ChartBloc extends Bloc<ChartEvent, ChartState> {
  late final WebSocketChannel channel;
  List<ChartData> chartData = [];
  Timer? timer;

  ChartBloc() : super(ChartInitial()) {
    final Uri wsUrl = Uri.parse('wss://ws.eodhistoricaldata.com/ws/crypto?api_token=demo');
    channel = WebSocketChannel.connect(wsUrl);
    on<SubscribeStreamEvent>(_onSubscribeStream);
    on<UpdateChartDataEvent>(_onUpdateChartData);

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (chartData.isNotEmpty) {
        add(UpdateChartDataEvent(chartData.last)); // Emit the latest data
      }
    });
  }

  Future<void> _onSubscribeStream(SubscribeStreamEvent event, Emitter<ChartState> emit) async {
    channel.sink.add('{"action": "subscribe", "symbols": "ETH-USD"}');
    await channel.ready;
    channel.stream.listen((message) {
      final data = json.decode(message);
      final chartDataPoint = ChartData.fromJson(data);
      chartData.add(chartDataPoint);
      if (chartData.length > 60) {
        // Keep only the last 60 seconds of data
        chartData.removeAt(0);
      }
    });
  }

  void _onUpdateChartData(UpdateChartDataEvent event, Emitter<ChartState> emit) {
    emit(ChartDataUpdated(List.from(chartData)));
  }

  @override
  Future<void> close() {
    timer?.cancel();
    channel.sink.close();
    return super.close();
  }
}
