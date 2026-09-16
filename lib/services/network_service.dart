import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkService {
  // 1. State variable MUST be static to be accessed by a static method
  static bool _isDialogShowing = false;

  // 2. The static listener called directly from main.dart
  static void listen(GlobalKey<NavigatorState> navKey) {
    
    Connectivity().onConnectivityChanged.listen((dynamic event) {
      final context = navKey.currentContext;
      
      // Abort if the widget tree hasn't painted yet
      if (context == null) return;

      // 3. Bulletproof check for package version differences
      final bool isOffline = event is List 
          ? event.contains(ConnectivityResult.none) 
          : event == ConnectivityResult.none;

      if (isOffline && !_isDialogShowing) {
        _isDialogShowing = true;
        
        showDialog(
          context: context,
          barrierDismissible: false, // Forces user to restore connection
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
        // Dismiss the dialog automatically when connection restores
        Navigator.pop(context);
        _isDialogShowing = false;
      }
    });
  }
}