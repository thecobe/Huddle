# Huddle – app mobile

Un'unica app per staff tecnico, atleti e genitori: l'interfaccia si adatta ai ruoli nella società selezionata.

```bash
flutter pub get
flutter gen-l10n
dart run build_runner build --delete-conflicting-outputs   # tipi GraphQL da lib/graphql/*.graphql
flutter run --dart-define-from-file=env/dev.json      # anche env/staging.json, env/prod.json
flutter test --concurrency=1
```

Test di integrazione contro l'API locale (magic link reale, da `pnpm dev:api`):

```bash
flutter test integration_test -d ID_SIMULATORE --dart-define-from-file=env/dev.json \
  --dart-define=MAGIC_LINK='huddle://auth/magic?token=…'
```

Vedi [docs/SVILUPPO.md](../../docs/SVILUPPO.md) per l'avvio dell'API locale.

## Link dalle e-mail

Schema `huddle://` registrato su iOS (`Info.plist`) e Android (`AndroidManifest.xml`):

- `huddle://auth/magic?token=…` → accesso con magic link
- `huddle://invitations/accept?token=…` → accettazione invito

In produzione vanno aggiunti Universal Links / App Links sul dominio web.

## Notifiche push

`lib/push/push_service.dart` registra il token del dispositivo sull'API (`registerDevice`).
La sorgente del token Firebase non è ancora collegata: servono il progetto Firebase e i file
`GoogleService-Info.plist` / `google-services.json`, poi un'implementazione di `PushTokenSource`
con `firebase_messaging`.
