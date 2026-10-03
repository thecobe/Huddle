import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';

import '../api/api_client.dart';
import 'attendance_repository.dart';

/// Invia la coda dell'appello: al ritorno della rete, al rientro in primo piano, dopo ogni modifica
/// e ogni minuto finché ci sono righe in sospeso. Dopo un errore di rete ritenta con attesa crescente.
class AttendanceSync with WidgetsBindingObserver {
  AttendanceSync(this._repo, {Stream<List<ConnectivityResult>>? connectivity})
      : _connectivity = connectivity ?? Connectivity().onConnectivityChanged;

  final AttendanceRepository _repo;
  final Stream<List<ConnectivityResult>> _connectivity;
  StreamSubscription<List<ConnectivityResult>>? _sub;
  Timer? _timer;
  Future<void>? _running;
  int _failures = 0;

  void start() {
    WidgetsBinding.instance.addObserver(this);
    _sub = _connectivity.listen((r) {
      if (!r.contains(ConnectivityResult.none)) trigger();
    });
    trigger();
  }

  void stop() {
    WidgetsBinding.instance.removeObserver(this);
    _sub?.cancel();
    _timer?.cancel();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) trigger();
  }

  /// Avvia un invio, se non ce n'è già uno in corso.
  Future<void> trigger() => _running ??= _run().whenComplete(() => _running = null);

  Future<void> _run() async {
    _timer?.cancel();
    bool empty;
    try {
      empty = await _repo.flush();
      _failures = 0;
    } on ApiException catch (e) {
      if (e.code != 'NETWORK' && e.code != 'UNAUTHENTICATED') rethrow;
      _failures++;
      empty = false;
    }
    if (!empty) {
      // 60 s a regime, più breve dopo i primi errori (10 s, 20 s, 40 s).
      final delay = Duration(seconds: _failures == 0 ? 60 : (5 << _failures.clamp(1, 3)).clamp(10, 60));
      _timer = Timer(delay, trigger);
    }
  }
}
