import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swo/modules/watchlist/watchlist.bloc.dart';
import 'package:swo/modules/watchlist/watchlist.state.dart';
import 'package:swo/ui/atoms/table-item.dart';

class WatchListModule extends StatefulWidget {
  const WatchListModule({super.key});

  @override
  State<WatchListModule> createState() => _WatchListModuleState();
}

class _WatchListModuleState extends State<WatchListModule> {
  @override
  void initState() {
    super.initState();
  }

  Widget createText(WatchState state) {
    if (state is WatchDataUpdated) {
      var data = state.data[0];
      return Column(
        children: [
          TableItem(
            sym: data.symbol,
            last: data.price.toStringAsFixed(2).toString(),
            chg: data.priceChangePercent.toStringAsFixed(2).toString(),
            chg2: data.priceChange.toStringAsFixed(2).toString(),
          ),
        ],
      );
    }
    return const Padding(
      padding: EdgeInsets.only(
        top: 5,
      ),
      child: Text(
        'Memuat...',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WatchBloc>(
      create: (context) => WatchBloc()..add(SubscribeStreamEvent()),
      child: BlocBuilder<WatchBloc, WatchState>(
        builder: (context, state) => Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              const TableItem(
                sym: 'Symbol',
                last: 'Last',
                chg: 'Chg',
                chg2: 'Chg%',
              ),
              Container(
                height: 5,
              ),
              createText(state),
            ],
          ),
        ),
      ),
    );
  }
}
