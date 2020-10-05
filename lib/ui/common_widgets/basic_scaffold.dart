import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:news_shot/helper/method_helper.dart';

class BasicScaffold extends StatefulWidget {
  final AppBar appBar;
  final Widget body;
  final BottomNavigationBar bottomNavigationBar;
  final String id;
  final Color backgroundColor;
  final FloatingActionButton floatingActionButton;
  final StreamController<String> errorController;
  final StreamController<String> successController;
  const BasicScaffold({
    Key key,
    this.appBar,
    @required this.body,
    this.errorController,
    this.floatingActionButton,
    this.id,
    this.successController,
    this.backgroundColor,
    this.bottomNavigationBar,
  }) : super(key: key);
  @override
  _BasicScaffoldState createState() => _BasicScaffoldState();
}

class _BasicScaffoldState extends State<BasicScaffold> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final StreamController<ConnectivityResult> _connectionController =
      StreamController();
  @override
  void dispose() {
    _connectionController?.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((conn) {
      _connectionController.add(conn);
    });
    getCurrentConnectivity();
    widget.errorController?.stream?.listen((s) => showSnack(s));
    widget.successController?.stream
        ?.listen((s) => showSnack(s, isSuccess: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: widget.appBar,
      backgroundColor: widget.backgroundColor,
      body: Stack(
        children: <Widget>[
          widget.body,
          Positioned(
            bottom: 0,
            child: StreamBuilder<ConnectivityResult>(
              stream: _connectionController.stream,
              builder: (context, snapshot) {
                return Visibility(
                  visible: snapshot.hasData &&
                      snapshot.data == ConnectivityResult.none,
                  child: Container(
                    width: double.maxFinite,
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: const Text(
                      'No internet connection!',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: widget.bottomNavigationBar,
      floatingActionButton: widget.floatingActionButton,
    );
  }

  void showSnack(String message, {bool isSuccess = false}) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: isSuccess ? Colors.green : Colors.red,
      behavior: SnackBarBehavior.floating,
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(message),
      ),
    ));
  }

  Future<void> getCurrentConnectivity() async {
    await zeroDelay();
    final connectivityResult = await Connectivity().checkConnectivity();
    _connectionController.add(connectivityResult);
  }
}
