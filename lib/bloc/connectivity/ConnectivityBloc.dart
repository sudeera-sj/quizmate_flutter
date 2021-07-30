import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizmate_flutter/api/connectivity_repo.dart';
import 'package:quizmate_flutter/models/util/connectivity_listener.dart';

/// The BLoC component for connectivity related operations
class ConnectivityBloc extends Cubit<bool> {
  final ConnectivityRepo _repo;
  final List<ConnectivityListener> _listeners;
  late StreamSubscription<Future<bool>> _subscription;

  ConnectivityBloc(this._repo, this._listeners) : super(false) {
    _subscription = listenToConnectivityChanges();
  }

  @override
  Future<void> close() async {
    _subscription.cancel();
    super.close();
  }

  /// Attempts to reach the API once every 5 seconds. Notifies the listeners of the result
  StreamSubscription<Future<bool>> listenToConnectivityChanges() {
    return Stream.periodic(
      Duration(seconds: 5),
      (_) async => _repo.checkConnectivity(),
    ).distinct((a, b) => a == b).listen(
      (event) async {
        final isConnected = await event;

        _listeners.forEach((element) {
          element.onConnectionChange(isConnected);
        });

        emit(isConnected);
      },
    );
  }
}
