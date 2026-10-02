import 'dart:io' show Platform;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api_client.dart';
import '../graphql/devices.graphql.dart';
import '../graphql/schema.graphql.dart';
import '../auth/session.dart';

/// Fonte del token push del dispositivo.
///
/// In Fase 0 l'implementazione predefinita non ne fornisce: l'integrazione Firebase Cloud Messaging
/// richiede i file di configurazione del progetto Firebase (GoogleService-Info.plist,
/// google-services.json) e va collegata qui implementando [PushTokenSource] con `firebase_messaging`.
abstract class PushTokenSource {
  Future<String?> currentToken();
  Stream<String> get onTokenRefresh;
}

class NoPushTokenSource implements PushTokenSource {
  @override
  Future<String?> currentToken() async => null;
  @override
  Stream<String> get onTokenRefresh => const Stream.empty();
}

final pushTokenSourceProvider = Provider<PushTokenSource>((_) => NoPushTokenSource());

/// Registra il token del dispositivo sull'API dopo il login, per le notifiche di Fase 1.
class PushRegistrar {
  PushRegistrar(this._api, this._source);
  final ApiClient _api;
  final PushTokenSource _source;
  String? _registered;

  Future<void> register() async {
    final token = await _source.currentToken();
    if (token == null || token == _registered) return;
    await _api.mutate(
      documentNodeMutationRegisterDevice,
      variables: Variables$Mutation$RegisterDevice(
        input: Input$RegisterDeviceInput(
          token: token,
          platform: Platform.isIOS ? Enum$DevicePlatform.IOS : Enum$DevicePlatform.ANDROID,
        ),
      ).toJson(),
    );
    _registered = token;
  }

  Future<void> unregister() async {
    final token = _registered;
    if (token == null) return;
    try {
      await _api.mutate(
        documentNodeMutationUnregisterDevice,
        variables: Variables$Mutation$UnregisterDevice(token: token).toJson(),
      );
    } on ApiException {
      // Il token scaduto verrà sovrascritto al prossimo login.
    }
    _registered = null;
  }
}

final pushRegistrarProvider = Provider<PushRegistrar>(
  (ref) => PushRegistrar(ref.read(apiClientProvider), ref.read(pushTokenSourceProvider)),
);
