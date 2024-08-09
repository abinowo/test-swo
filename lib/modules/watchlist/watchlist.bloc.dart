import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swo/modules/watchlist/watchlist.state.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:async';

// Bloc
class WatchBloc extends Bloc<WatchEvent, WatchState> {
  late final WebSocketChannel channel;
  List<WatchData> watchData = [];
  Timer? timer;

  WatchBloc() : super(WatchInitial()) {
    final Uri wsUrl = Uri.parse('wss://ws.eodhistoricaldata.com/ws/crypto?api_token=demo');
    channel = WebSocketChannel.connect(wsUrl);
    on<SubscribeStreamEvent>(_onSubscribeStream);
    on<UpdateWatchDataEvent>(_onUpdateWatchData);

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (watchData.isNotEmpty) {
        add(UpdateWatchDataEvent(watchData.last)); // Emit the latest data
      }
    });
  }

  Future<void> _onSubscribeStream(SubscribeStreamEvent event, Emitter<WatchState> emit) async {
    channel.sink.add('{"action": "subscribe", "symbols": "ETH-USD"}');
    await channel.ready;
    channel.stream.listen((message) {
      final data = json.decode(message);
      final watchDataPoint = WatchData.fromJson(data);
      watchData.add(watchDataPoint);
      if (watchData.length > 1) {
        // Keep only the last 60 seconds of data
        watchData.removeAt(0);
      }
    });
  }

  void _onUpdateWatchData(UpdateWatchDataEvent event, Emitter<WatchState> emit) {
    emit(WatchDataUpdated(List.from(watchData)));
  }

  @override
  Future<void> close() {
    timer?.cancel();
    channel.sink.close();
    return super.close();
  }
}
