/// Used to listen to changes in the internet connectivity
abstract class ConnectivityListener {
  /// Called upon each variation in the internet connection
  void onConnectionChange(bool isConnected);
}
