import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkService {

  static bool _isDialogShowing = false;

  static void listen(GlobalKey<NavigatorState> navKey) {
    
    Connectivity().onConnectivityChanged.listen((dynamic event) {
      final context = navKey.currentContext;
      

      if (context == null) return;

      final bool isOffline = event is List 
          ? event.contains(ConnectivityResult.none) 
          : event == ConnectivityResult.none;

      if (isOffline && !_isDialogShowing) {
        _isDialogShowing = true;
        
        showDialog(
          context: context,
          barrierDismissible: false, 
          builder: (_) => const AlertDialog(
            title: Row(
              children: [
                Icon(Icons.wifi_off, color: Colors.red),
                SizedBox(width: 8),
                Text('Connection Error', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            content: Text(
              'Your internet connection has been interrupted. Please check your settings and try again.',
            ),
          ),
        );
      } else if (!isOffline && _isDialogShowing) {
        Navigator.pop(context);
        _isDialogShowing = false;
      }
    });
  }
}