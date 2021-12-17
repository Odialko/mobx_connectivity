import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_conectivity/stores/connectivity_store.dart';

class ConnectivityScreen extends StatefulWidget {
  final ConnectivityStore store;

  const ConnectivityScreen({Key? key, required this.store}) : super(key: key);

  @override
  _ConnectivityScreenState createState() => _ConnectivityScreenState();
}

class _ConnectivityScreenState extends State<ConnectivityScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  ReactionDisposer? _disposer;
  late ConnectivityStore store;

  @override
  void initState() {
    super.initState();

    /// a delay is used to avoid showing the snackbar too much when the connection drops in and out repeatedly
    _disposer = reaction(
      (_) => widget.store.connectivityStream.value,
      (result) => _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(result == ConnectivityResult.none
              ? 'You\'re offline'
              : 'You\'re online'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _disposer!();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // store = Provider.of<ConnectivityStore>(context, listen: false);
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text('MobX connectivity'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  'Turn your connection on/off for approximately 4 seconds to see the app respond to changes in your connection status.'),
            ),
          ],
        ),
      ),
    );
  }
}
