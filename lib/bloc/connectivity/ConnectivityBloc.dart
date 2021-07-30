import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizmate_flutter/api/connectivity_repo.dart';
import 'package:quizmate_flutter/models/util/connectivity_listener.dart';

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
