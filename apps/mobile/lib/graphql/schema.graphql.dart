class Input$AcceptInvitationInput {
  factory Input$AcceptInvitationInput({
    required bool acceptTerms,
    String? fullName,
    String? password,
    required String token,
  }) => Input$AcceptInvitationInput._({
    r'acceptTerms': acceptTerms,
    if (fullName != null) r'fullName': fullName,
    if (password != null) r'password': password,
    r'token': token,
  });

  Input$AcceptInvitationInput._(this._$data);

  factory Input$AcceptInvitationInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$acceptTerms = data['acceptTerms'];
    result$data['acceptTerms'] = (l$acceptTerms as bool);
    if (data.containsKey('fullName')) {
      final l$fullName = data['fullName'];
      result$data['fullName'] = (l$fullName as String?);
    }
    if (data.containsKey('password')) {
      final l$password = data['password'];
      result$data['password'] = (l$password as String?);
    }
    final l$token = data['token'];
    result$data['token'] = (l$token as String);
    return Input$AcceptInvitationInput._(result$data);
  }

  Map<String, dynamic> _$data;

  bool get acceptTerms => (_$data['acceptTerms'] as bool);

  String? get fullName => (_$data['fullName'] as String?);

  String? get password => (_$data['password'] as String?);

  String get token => (_$data['token'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$acceptTerms = acceptTerms;
    result$data['acceptTerms'] = l$acceptTerms;
    if (_$data.containsKey('fullName')) {
      final l$fullName = fullName;
      result$data['fullName'] = l$fullName;
    }
    if (_$data.containsKey('password')) {
      final l$password = password;
      result$data['password'] = l$password;
    }
    final l$token = token;
    result$data['token'] = l$token;
    return result$data;
  }

  CopyWith$Input$AcceptInvitationInput<Input$AcceptInvitationInput>
  get copyWith => CopyWith$Input$AcceptInvitationInput(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$AcceptInvitationInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$acceptTerms = acceptTerms;
    final lOther$acceptTerms = other.acceptTerms;
    if (l$acceptTerms != lOther$acceptTerms) {
      return false;
    }
    final l$fullName = fullName;
    final lOther$fullName = other.fullName;
    if (_$data.containsKey('fullName') !=
        other._$data.containsKey('fullName')) {
      return false;
    }
    if (l$fullName != lOther$fullName) {
      return false;
    }
    final l$password = password;
    final lOther$password = other.password;
    if (_$data.containsKey('password') !=
        other._$data.containsKey('password')) {
      return false;
    }
    if (l$password != lOther$password) {
      return false;
    }
    final l$token = token;
    final lOther$token = other.token;
    if (l$token != lOther$token) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$acceptTerms = acceptTerms;
    final l$fullName = fullName;
    final l$password = password;
    final l$token = token;
    return Object.hashAll([
      l$acceptTerms,
      _$data.containsKey('fullName') ? l$fullName : const {},
      _$data.containsKey('password') ? l$password : const {},
      l$token,
    ]);
  }
}

abstract class CopyWith$Input$AcceptInvitationInput<TRes> {
  factory CopyWith$Input$AcceptInvitationInput(
    Input$AcceptInvitationInput instance,
    TRes Function(Input$AcceptInvitationInput) then,
  ) = _CopyWithImpl$Input$AcceptInvitationInput;

  factory CopyWith$Input$AcceptInvitationInput.stub(TRes res) =
      _CopyWithStubImpl$Input$AcceptInvitationInput;

  TRes call({
    bool? acceptTerms,
    String? fullName,
    String? password,
    String? token,
  });
}

class _CopyWithImpl$Input$AcceptInvitationInput<TRes>
    implements CopyWith$Input$AcceptInvitationInput<TRes> {
  _CopyWithImpl$Input$AcceptInvitationInput(this._instance, this._then);

  final Input$AcceptInvitationInput _instance;

  final TRes Function(Input$AcceptInvitationInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? acceptTerms = _undefined,
    Object? fullName = _undefined,
    Object? password = _undefined,
    Object? token = _undefined,
  }) => _then(
    Input$AcceptInvitationInput._({
      ..._instance._$data,
      if (acceptTerms != _undefined && acceptTerms != null)
        'acceptTerms': (acceptTerms as bool),
      if (fullName != _undefined) 'fullName': (fullName as String?),
      if (password != _undefined) 'password': (password as String?),
      if (token != _undefined && token != null) 'token': (token as String),
    }),
  );
}

class _CopyWithStubImpl$Input$AcceptInvitationInput<TRes>
    implements CopyWith$Input$AcceptInvitationInput<TRes> {
  _CopyWithStubImpl$Input$AcceptInvitationInput(this._res);

  TRes _res;

  call({
    bool? acceptTerms,
    String? fullName,
    String? password,
    String? token,
  }) => _res;
}

class Input$ClubInput {
  factory Input$ClubInput({
    String? addressLine,
    String? city,
    String? email,
    List<String>? federations,
    String? legalName,
    required String name,
    String? phone,
    String? postalCode,
    String? province,
    String? sport,
    String? taxCode,
    String? vatNumber,
  }) => Input$ClubInput._({
    if (addressLine != null) r'addressLine': addressLine,
    if (city != null) r'city': city,
    if (email != null) r'email': email,
    if (federations != null) r'federations': federations,
    if (legalName != null) r'legalName': legalName,
    r'name': name,
    if (phone != null) r'phone': phone,
    if (postalCode != null) r'postalCode': postalCode,
    if (province != null) r'province': province,
    if (sport != null) r'sport': sport,
    if (taxCode != null) r'taxCode': taxCode,
    if (vatNumber != null) r'vatNumber': vatNumber,
  });

  Input$ClubInput._(this._$data);

  factory Input$ClubInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('addressLine')) {
      final l$addressLine = data['addressLine'];
      result$data['addressLine'] = (l$addressLine as String?);
    }
    if (data.containsKey('city')) {
      final l$city = data['city'];
      result$data['city'] = (l$city as String?);
    }
    if (data.containsKey('email')) {
      final l$email = data['email'];
      result$data['email'] = (l$email as String?);
    }
    if (data.containsKey('federations')) {
      final l$federations = data['federations'];
      result$data['federations'] = (l$federations as List<dynamic>?)
          ?.map((e) => (e as String))
          .toList();
    }
    if (data.containsKey('legalName')) {
      final l$legalName = data['legalName'];
      result$data['legalName'] = (l$legalName as String?);
    }
    final l$name = data['name'];
    result$data['name'] = (l$name as String);
    if (data.containsKey('phone')) {
      final l$phone = data['phone'];
      result$data['phone'] = (l$phone as String?);
    }
    if (data.containsKey('postalCode')) {
      final l$postalCode = data['postalCode'];
      result$data['postalCode'] = (l$postalCode as String?);
    }
    if (data.containsKey('province')) {
      final l$province = data['province'];
      result$data['province'] = (l$province as String?);
    }
    if (data.containsKey('sport')) {
      final l$sport = data['sport'];
      result$data['sport'] = (l$sport as String?);
    }
    if (data.containsKey('taxCode')) {
      final l$taxCode = data['taxCode'];
      result$data['taxCode'] = (l$taxCode as String?);
    }
    if (data.containsKey('vatNumber')) {
      final l$vatNumber = data['vatNumber'];
      result$data['vatNumber'] = (l$vatNumber as String?);
    }
    return Input$ClubInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String? get addressLine => (_$data['addressLine'] as String?);

  String? get city => (_$data['city'] as String?);

  String? get email => (_$data['email'] as String?);

  List<String>? get federations => (_$data['federations'] as List<String>?);

  String? get legalName => (_$data['legalName'] as String?);

  String get name => (_$data['name'] as String);

  String? get phone => (_$data['phone'] as String?);

  String? get postalCode => (_$data['postalCode'] as String?);

  String? get province => (_$data['province'] as String?);

  String? get sport => (_$data['sport'] as String?);

  String? get taxCode => (_$data['taxCode'] as String?);

  String? get vatNumber => (_$data['vatNumber'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('addressLine')) {
      final l$addressLine = addressLine;
      result$data['addressLine'] = l$addressLine;
    }
    if (_$data.containsKey('city')) {
      final l$city = city;
      result$data['city'] = l$city;
    }
    if (_$data.containsKey('email')) {
      final l$email = email;
      result$data['email'] = l$email;
    }
    if (_$data.containsKey('federations')) {
      final l$federations = federations;
      result$data['federations'] = l$federations?.map((e) => e).toList();
    }
    if (_$data.containsKey('legalName')) {
      final l$legalName = legalName;
      result$data['legalName'] = l$legalName;
    }
    final l$name = name;
    result$data['name'] = l$name;
    if (_$data.containsKey('phone')) {
      final l$phone = phone;
      result$data['phone'] = l$phone;
    }
    if (_$data.containsKey('postalCode')) {
      final l$postalCode = postalCode;
      result$data['postalCode'] = l$postalCode;
    }
    if (_$data.containsKey('province')) {
      final l$province = province;
      result$data['province'] = l$province;
    }
    if (_$data.containsKey('sport')) {
      final l$sport = sport;
      result$data['sport'] = l$sport;
    }
    if (_$data.containsKey('taxCode')) {
      final l$taxCode = taxCode;
      result$data['taxCode'] = l$taxCode;
    }
    if (_$data.containsKey('vatNumber')) {
      final l$vatNumber = vatNumber;
      result$data['vatNumber'] = l$vatNumber;
    }
    return result$data;
  }

  CopyWith$Input$ClubInput<Input$ClubInput> get copyWith =>
      CopyWith$Input$ClubInput(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$ClubInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$addressLine = addressLine;
    final lOther$addressLine = other.addressLine;
    if (_$data.containsKey('addressLine') !=
        other._$data.containsKey('addressLine')) {
      return false;
    }
    if (l$addressLine != lOther$addressLine) {
      return false;
    }
    final l$city = city;
    final lOther$city = other.city;
    if (_$data.containsKey('city') != other._$data.containsKey('city')) {
      return false;
    }
    if (l$city != lOther$city) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (_$data.containsKey('email') != other._$data.containsKey('email')) {
      return false;
    }
    if (l$email != lOther$email) {
      return false;
    }
    final l$federations = federations;
    final lOther$federations = other.federations;
    if (_$data.containsKey('federations') !=
        other._$data.containsKey('federations')) {
      return false;
    }
    if (l$federations != null && lOther$federations != null) {
      if (l$federations.length != lOther$federations.length) {
        return false;
      }
      for (int i = 0; i < l$federations.length; i++) {
        final l$federations$entry = l$federations[i];
        final lOther$federations$entry = lOther$federations[i];
        if (l$federations$entry != lOther$federations$entry) {
          return false;
        }
      }
    } else if (l$federations != lOther$federations) {
      return false;
    }
    final l$legalName = legalName;
    final lOther$legalName = other.legalName;
    if (_$data.containsKey('legalName') !=
        other._$data.containsKey('legalName')) {
      return false;
    }
    if (l$legalName != lOther$legalName) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$phone = phone;
    final lOther$phone = other.phone;
    if (_$data.containsKey('phone') != other._$data.containsKey('phone')) {
      return false;
    }
    if (l$phone != lOther$phone) {
      return false;
    }
    final l$postalCode = postalCode;
    final lOther$postalCode = other.postalCode;
    if (_$data.containsKey('postalCode') !=
        other._$data.containsKey('postalCode')) {
      return false;
    }
    if (l$postalCode != lOther$postalCode) {
      return false;
    }
    final l$province = province;
    final lOther$province = other.province;
    if (_$data.containsKey('province') !=
        other._$data.containsKey('province')) {
      return false;
    }
    if (l$province != lOther$province) {
      return false;
    }
    final l$sport = sport;
    final lOther$sport = other.sport;
    if (_$data.containsKey('sport') != other._$data.containsKey('sport')) {
      return false;
    }
    if (l$sport != lOther$sport) {
      return false;
    }
    final l$taxCode = taxCode;
    final lOther$taxCode = other.taxCode;
    if (_$data.containsKey('taxCode') != other._$data.containsKey('taxCode')) {
      return false;
    }
    if (l$taxCode != lOther$taxCode) {
      return false;
    }
    final l$vatNumber = vatNumber;
    final lOther$vatNumber = other.vatNumber;
    if (_$data.containsKey('vatNumber') !=
        other._$data.containsKey('vatNumber')) {
      return false;
    }
    if (l$vatNumber != lOther$vatNumber) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$addressLine = addressLine;
    final l$city = city;
    final l$email = email;
    final l$federations = federations;
    final l$legalName = legalName;
    final l$name = name;
    final l$phone = phone;
    final l$postalCode = postalCode;
    final l$province = province;
    final l$sport = sport;
    final l$taxCode = taxCode;
    final l$vatNumber = vatNumber;
    return Object.hashAll([
      _$data.containsKey('addressLine') ? l$addressLine : const {},
      _$data.containsKey('city') ? l$city : const {},
      _$data.containsKey('email') ? l$email : const {},
      _$data.containsKey('federations')
          ? l$federations == null
                ? null
                : Object.hashAll(l$federations.map((v) => v))
          : const {},
      _$data.containsKey('legalName') ? l$legalName : const {},
      l$name,
      _$data.containsKey('phone') ? l$phone : const {},
      _$data.containsKey('postalCode') ? l$postalCode : const {},
      _$data.containsKey('province') ? l$province : const {},
      _$data.containsKey('sport') ? l$sport : const {},
      _$data.containsKey('taxCode') ? l$taxCode : const {},
      _$data.containsKey('vatNumber') ? l$vatNumber : const {},
    ]);
  }
}

abstract class CopyWith$Input$ClubInput<TRes> {
  factory CopyWith$Input$ClubInput(
    Input$ClubInput instance,
    TRes Function(Input$ClubInput) then,
  ) = _CopyWithImpl$Input$ClubInput;

  factory CopyWith$Input$ClubInput.stub(TRes res) =
      _CopyWithStubImpl$Input$ClubInput;

  TRes call({
    String? addressLine,
    String? city,
    String? email,
    List<String>? federations,
    String? legalName,
    String? name,
    String? phone,
    String? postalCode,
    String? province,
    String? sport,
    String? taxCode,
    String? vatNumber,
  });
}

class _CopyWithImpl$Input$ClubInput<TRes>
    implements CopyWith$Input$ClubInput<TRes> {
  _CopyWithImpl$Input$ClubInput(this._instance, this._then);

  final Input$ClubInput _instance;

  final TRes Function(Input$ClubInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? addressLine = _undefined,
    Object? city = _undefined,
    Object? email = _undefined,
    Object? federations = _undefined,
    Object? legalName = _undefined,
    Object? name = _undefined,
    Object? phone = _undefined,
    Object? postalCode = _undefined,
    Object? province = _undefined,
    Object? sport = _undefined,
    Object? taxCode = _undefined,
    Object? vatNumber = _undefined,
  }) => _then(
    Input$ClubInput._({
      ..._instance._$data,
      if (addressLine != _undefined) 'addressLine': (addressLine as String?),
      if (city != _undefined) 'city': (city as String?),
      if (email != _undefined) 'email': (email as String?),
      if (federations != _undefined)
        'federations': (federations as List<String>?),
      if (legalName != _undefined) 'legalName': (legalName as String?),
      if (name != _undefined && name != null) 'name': (name as String),
      if (phone != _undefined) 'phone': (phone as String?),
      if (postalCode != _undefined) 'postalCode': (postalCode as String?),
      if (province != _undefined) 'province': (province as String?),
      if (sport != _undefined) 'sport': (sport as String?),
      if (taxCode != _undefined) 'taxCode': (taxCode as String?),
      if (vatNumber != _undefined) 'vatNumber': (vatNumber as String?),
    }),
  );
}

class _CopyWithStubImpl$Input$ClubInput<TRes>
    implements CopyWith$Input$ClubInput<TRes> {
  _CopyWithStubImpl$Input$ClubInput(this._res);

  TRes _res;

  call({
    String? addressLine,
    String? city,
    String? email,
    List<String>? federations,
    String? legalName,
    String? name,
    String? phone,
    String? postalCode,
    String? province,
    String? sport,
    String? taxCode,
    String? vatNumber,
  }) => _res;
}

class Input$CopyTeamsInput {
  factory Input$CopyTeamsInput({
    required String fromSeasonId,
    required bool includePlayers,
    required String toSeasonId,
  }) => Input$CopyTeamsInput._({
    r'fromSeasonId': fromSeasonId,
    r'includePlayers': includePlayers,
    r'toSeasonId': toSeasonId,
  });

  Input$CopyTeamsInput._(this._$data);

  factory Input$CopyTeamsInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$fromSeasonId = data['fromSeasonId'];
    result$data['fromSeasonId'] = (l$fromSeasonId as String);
    final l$includePlayers = data['includePlayers'];
    result$data['includePlayers'] = (l$includePlayers as bool);
    final l$toSeasonId = data['toSeasonId'];
    result$data['toSeasonId'] = (l$toSeasonId as String);
    return Input$CopyTeamsInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get fromSeasonId => (_$data['fromSeasonId'] as String);

  bool get includePlayers => (_$data['includePlayers'] as bool);

  String get toSeasonId => (_$data['toSeasonId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$fromSeasonId = fromSeasonId;
    result$data['fromSeasonId'] = l$fromSeasonId;
    final l$includePlayers = includePlayers;
    result$data['includePlayers'] = l$includePlayers;
    final l$toSeasonId = toSeasonId;
    result$data['toSeasonId'] = l$toSeasonId;
    return result$data;
  }

  CopyWith$Input$CopyTeamsInput<Input$CopyTeamsInput> get copyWith =>
      CopyWith$Input$CopyTeamsInput(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$CopyTeamsInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$fromSeasonId = fromSeasonId;
    final lOther$fromSeasonId = other.fromSeasonId;
    if (l$fromSeasonId != lOther$fromSeasonId) {
      return false;
    }
    final l$includePlayers = includePlayers;
    final lOther$includePlayers = other.includePlayers;
    if (l$includePlayers != lOther$includePlayers) {
      return false;
    }
    final l$toSeasonId = toSeasonId;
    final lOther$toSeasonId = other.toSeasonId;
    if (l$toSeasonId != lOther$toSeasonId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$fromSeasonId = fromSeasonId;
    final l$includePlayers = includePlayers;
    final l$toSeasonId = toSeasonId;
    return Object.hashAll([l$fromSeasonId, l$includePlayers, l$toSeasonId]);
  }
}

abstract class CopyWith$Input$CopyTeamsInput<TRes> {
  factory CopyWith$Input$CopyTeamsInput(
    Input$CopyTeamsInput instance,
    TRes Function(Input$CopyTeamsInput) then,
  ) = _CopyWithImpl$Input$CopyTeamsInput;

  factory CopyWith$Input$CopyTeamsInput.stub(TRes res) =
      _CopyWithStubImpl$Input$CopyTeamsInput;

  TRes call({String? fromSeasonId, bool? includePlayers, String? toSeasonId});
}

class _CopyWithImpl$Input$CopyTeamsInput<TRes>
    implements CopyWith$Input$CopyTeamsInput<TRes> {
  _CopyWithImpl$Input$CopyTeamsInput(this._instance, this._then);

  final Input$CopyTeamsInput _instance;

  final TRes Function(Input$CopyTeamsInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? fromSeasonId = _undefined,
    Object? includePlayers = _undefined,
    Object? toSeasonId = _undefined,
  }) => _then(
    Input$CopyTeamsInput._({
      ..._instance._$data,
      if (fromSeasonId != _undefined && fromSeasonId != null)
        'fromSeasonId': (fromSeasonId as String),
      if (includePlayers != _undefined && includePlayers != null)
        'includePlayers': (includePlayers as bool),
      if (toSeasonId != _undefined && toSeasonId != null)
        'toSeasonId': (toSeasonId as String),
    }),
  );
}

class _CopyWithStubImpl$Input$CopyTeamsInput<TRes>
    implements CopyWith$Input$CopyTeamsInput<TRes> {
  _CopyWithStubImpl$Input$CopyTeamsInput(this._res);

  TRes _res;

  call({String? fromSeasonId, bool? includePlayers, String? toSeasonId}) =>
      _res;
}

class Input$InviteMemberInput {
  factory Input$InviteMemberInput({
    required String email,
    String? personId,
    required Enum$MembershipRole role,
    String? teamId,
  }) => Input$InviteMemberInput._({
    r'email': email,
    if (personId != null) r'personId': personId,
    r'role': role,
    if (teamId != null) r'teamId': teamId,
  });

  Input$InviteMemberInput._(this._$data);

  factory Input$InviteMemberInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$email = data['email'];
    result$data['email'] = (l$email as String);
    if (data.containsKey('personId')) {
      final l$personId = data['personId'];
      result$data['personId'] = (l$personId as String?);
    }
    final l$role = data['role'];
    result$data['role'] = fromJson$Enum$MembershipRole((l$role as String));
    if (data.containsKey('teamId')) {
      final l$teamId = data['teamId'];
      result$data['teamId'] = (l$teamId as String?);
    }
    return Input$InviteMemberInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get email => (_$data['email'] as String);

  String? get personId => (_$data['personId'] as String?);

  Enum$MembershipRole get role => (_$data['role'] as Enum$MembershipRole);

  String? get teamId => (_$data['teamId'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$email = email;
    result$data['email'] = l$email;
    if (_$data.containsKey('personId')) {
      final l$personId = personId;
      result$data['personId'] = l$personId;
    }
    final l$role = role;
    result$data['role'] = toJson$Enum$MembershipRole(l$role);
    if (_$data.containsKey('teamId')) {
      final l$teamId = teamId;
      result$data['teamId'] = l$teamId;
    }
    return result$data;
  }

  CopyWith$Input$InviteMemberInput<Input$InviteMemberInput> get copyWith =>
      CopyWith$Input$InviteMemberInput(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$InviteMemberInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (l$email != lOther$email) {
      return false;
    }
    final l$personId = personId;
    final lOther$personId = other.personId;
    if (_$data.containsKey('personId') !=
        other._$data.containsKey('personId')) {
      return false;
    }
    if (l$personId != lOther$personId) {
      return false;
    }
    final l$role = role;
    final lOther$role = other.role;
    if (l$role != lOther$role) {
      return false;
    }
    final l$teamId = teamId;
    final lOther$teamId = other.teamId;
    if (_$data.containsKey('teamId') != other._$data.containsKey('teamId')) {
      return false;
    }
    if (l$teamId != lOther$teamId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$email = email;
    final l$personId = personId;
    final l$role = role;
    final l$teamId = teamId;
    return Object.hashAll([
      l$email,
      _$data.containsKey('personId') ? l$personId : const {},
      l$role,
      _$data.containsKey('teamId') ? l$teamId : const {},
    ]);
  }
}

abstract class CopyWith$Input$InviteMemberInput<TRes> {
  factory CopyWith$Input$InviteMemberInput(
    Input$InviteMemberInput instance,
    TRes Function(Input$InviteMemberInput) then,
  ) = _CopyWithImpl$Input$InviteMemberInput;

  factory CopyWith$Input$InviteMemberInput.stub(TRes res) =
      _CopyWithStubImpl$Input$InviteMemberInput;

  TRes call({
    String? email,
    String? personId,
    Enum$MembershipRole? role,
    String? teamId,
  });
}

class _CopyWithImpl$Input$InviteMemberInput<TRes>
    implements CopyWith$Input$InviteMemberInput<TRes> {
  _CopyWithImpl$Input$InviteMemberInput(this._instance, this._then);

  final Input$InviteMemberInput _instance;

  final TRes Function(Input$InviteMemberInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? email = _undefined,
    Object? personId = _undefined,
    Object? role = _undefined,
    Object? teamId = _undefined,
  }) => _then(
    Input$InviteMemberInput._({
      ..._instance._$data,
      if (email != _undefined && email != null) 'email': (email as String),
      if (personId != _undefined) 'personId': (personId as String?),
      if (role != _undefined && role != null)
        'role': (role as Enum$MembershipRole),
      if (teamId != _undefined) 'teamId': (teamId as String?),
    }),
  );
}

class _CopyWithStubImpl$Input$InviteMemberInput<TRes>
    implements CopyWith$Input$InviteMemberInput<TRes> {
  _CopyWithStubImpl$Input$InviteMemberInput(this._res);

  TRes _res;

  call({
    String? email,
    String? personId,
    Enum$MembershipRole? role,
    String? teamId,
  }) => _res;
}

class Input$LoginInput {
  factory Input$LoginInput({required String email, required String password}) =>
      Input$LoginInput._({r'email': email, r'password': password});

  Input$LoginInput._(this._$data);

  factory Input$LoginInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$email = data['email'];
    result$data['email'] = (l$email as String);
    final l$password = data['password'];
    result$data['password'] = (l$password as String);
    return Input$LoginInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get email => (_$data['email'] as String);

  String get password => (_$data['password'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$email = email;
    result$data['email'] = l$email;
    final l$password = password;
    result$data['password'] = l$password;
    return result$data;
  }

  CopyWith$Input$LoginInput<Input$LoginInput> get copyWith =>
      CopyWith$Input$LoginInput(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$LoginInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (l$email != lOther$email) {
      return false;
    }
    final l$password = password;
    final lOther$password = other.password;
    if (l$password != lOther$password) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$email = email;
    final l$password = password;
    return Object.hashAll([l$email, l$password]);
  }
}

abstract class CopyWith$Input$LoginInput<TRes> {
  factory CopyWith$Input$LoginInput(
    Input$LoginInput instance,
    TRes Function(Input$LoginInput) then,
  ) = _CopyWithImpl$Input$LoginInput;

  factory CopyWith$Input$LoginInput.stub(TRes res) =
      _CopyWithStubImpl$Input$LoginInput;

  TRes call({String? email, String? password});
}

class _CopyWithImpl$Input$LoginInput<TRes>
    implements CopyWith$Input$LoginInput<TRes> {
  _CopyWithImpl$Input$LoginInput(this._instance, this._then);

  final Input$LoginInput _instance;

  final TRes Function(Input$LoginInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? email = _undefined, Object? password = _undefined}) =>
      _then(
        Input$LoginInput._({
          ..._instance._$data,
          if (email != _undefined && email != null) 'email': (email as String),
          if (password != _undefined && password != null)
            'password': (password as String),
        }),
      );
}

class _CopyWithStubImpl$Input$LoginInput<TRes>
    implements CopyWith$Input$LoginInput<TRes> {
  _CopyWithStubImpl$Input$LoginInput(this._res);

  TRes _res;

  call({String? email, String? password}) => _res;
}

class Input$PeopleFilter {
  factory Input$PeopleFilter({
    Enum$PersonCategory? category,
    bool? includeArchived,
    String? search,
    String? teamId,
  }) => Input$PeopleFilter._({
    if (category != null) r'category': category,
    if (includeArchived != null) r'includeArchived': includeArchived,
    if (search != null) r'search': search,
    if (teamId != null) r'teamId': teamId,
  });

  Input$PeopleFilter._(this._$data);

  factory Input$PeopleFilter.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('category')) {
      final l$category = data['category'];
      result$data['category'] = l$category == null
          ? null
          : fromJson$Enum$PersonCategory((l$category as String));
    }
    if (data.containsKey('includeArchived')) {
      final l$includeArchived = data['includeArchived'];
      result$data['includeArchived'] = (l$includeArchived as bool?);
    }
    if (data.containsKey('search')) {
      final l$search = data['search'];
      result$data['search'] = (l$search as String?);
    }
    if (data.containsKey('teamId')) {
      final l$teamId = data['teamId'];
      result$data['teamId'] = (l$teamId as String?);
    }
    return Input$PeopleFilter._(result$data);
  }

  Map<String, dynamic> _$data;

  Enum$PersonCategory? get category =>
      (_$data['category'] as Enum$PersonCategory?);

  bool? get includeArchived => (_$data['includeArchived'] as bool?);

  String? get search => (_$data['search'] as String?);

  String? get teamId => (_$data['teamId'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('category')) {
      final l$category = category;
      result$data['category'] = l$category == null
          ? null
          : toJson$Enum$PersonCategory(l$category);
    }
    if (_$data.containsKey('includeArchived')) {
      final l$includeArchived = includeArchived;
      result$data['includeArchived'] = l$includeArchived;
    }
    if (_$data.containsKey('search')) {
      final l$search = search;
      result$data['search'] = l$search;
    }
    if (_$data.containsKey('teamId')) {
      final l$teamId = teamId;
      result$data['teamId'] = l$teamId;
    }
    return result$data;
  }

  CopyWith$Input$PeopleFilter<Input$PeopleFilter> get copyWith =>
      CopyWith$Input$PeopleFilter(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$PeopleFilter || runtimeType != other.runtimeType) {
      return false;
    }
    final l$category = category;
    final lOther$category = other.category;
    if (_$data.containsKey('category') !=
        other._$data.containsKey('category')) {
      return false;
    }
    if (l$category != lOther$category) {
      return false;
    }
    final l$includeArchived = includeArchived;
    final lOther$includeArchived = other.includeArchived;
    if (_$data.containsKey('includeArchived') !=
        other._$data.containsKey('includeArchived')) {
      return false;
    }
    if (l$includeArchived != lOther$includeArchived) {
      return false;
    }
    final l$search = search;
    final lOther$search = other.search;
    if (_$data.containsKey('search') != other._$data.containsKey('search')) {
      return false;
    }
    if (l$search != lOther$search) {
      return false;
    }
    final l$teamId = teamId;
    final lOther$teamId = other.teamId;
    if (_$data.containsKey('teamId') != other._$data.containsKey('teamId')) {
      return false;
    }
    if (l$teamId != lOther$teamId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$category = category;
    final l$includeArchived = includeArchived;
    final l$search = search;
    final l$teamId = teamId;
    return Object.hashAll([
      _$data.containsKey('category') ? l$category : const {},
      _$data.containsKey('includeArchived') ? l$includeArchived : const {},
      _$data.containsKey('search') ? l$search : const {},
      _$data.containsKey('teamId') ? l$teamId : const {},
    ]);
  }
}

abstract class CopyWith$Input$PeopleFilter<TRes> {
  factory CopyWith$Input$PeopleFilter(
    Input$PeopleFilter instance,
    TRes Function(Input$PeopleFilter) then,
  ) = _CopyWithImpl$Input$PeopleFilter;

  factory CopyWith$Input$PeopleFilter.stub(TRes res) =
      _CopyWithStubImpl$Input$PeopleFilter;

  TRes call({
    Enum$PersonCategory? category,
    bool? includeArchived,
    String? search,
    String? teamId,
  });
}

class _CopyWithImpl$Input$PeopleFilter<TRes>
    implements CopyWith$Input$PeopleFilter<TRes> {
  _CopyWithImpl$Input$PeopleFilter(this._instance, this._then);

  final Input$PeopleFilter _instance;

  final TRes Function(Input$PeopleFilter) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? category = _undefined,
    Object? includeArchived = _undefined,
    Object? search = _undefined,
    Object? teamId = _undefined,
  }) => _then(
    Input$PeopleFilter._({
      ..._instance._$data,
      if (category != _undefined)
        'category': (category as Enum$PersonCategory?),
      if (includeArchived != _undefined)
        'includeArchived': (includeArchived as bool?),
      if (search != _undefined) 'search': (search as String?),
      if (teamId != _undefined) 'teamId': (teamId as String?),
    }),
  );
}

class _CopyWithStubImpl$Input$PeopleFilter<TRes>
    implements CopyWith$Input$PeopleFilter<TRes> {
  _CopyWithStubImpl$Input$PeopleFilter(this._res);

  TRes _res;

  call({
    Enum$PersonCategory? category,
    bool? includeArchived,
    String? search,
    String? teamId,
  }) => _res;
}

class Input$PersonContactsInput {
  factory Input$PersonContactsInput({
    String? addressLine,
    String? city,
    String? email,
    String? phone,
    String? postalCode,
    String? province,
  }) => Input$PersonContactsInput._({
    if (addressLine != null) r'addressLine': addressLine,
    if (city != null) r'city': city,
    if (email != null) r'email': email,
    if (phone != null) r'phone': phone,
    if (postalCode != null) r'postalCode': postalCode,
    if (province != null) r'province': province,
  });

  Input$PersonContactsInput._(this._$data);

  factory Input$PersonContactsInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('addressLine')) {
      final l$addressLine = data['addressLine'];
      result$data['addressLine'] = (l$addressLine as String?);
    }
    if (data.containsKey('city')) {
      final l$city = data['city'];
      result$data['city'] = (l$city as String?);
    }
    if (data.containsKey('email')) {
      final l$email = data['email'];
      result$data['email'] = (l$email as String?);
    }
    if (data.containsKey('phone')) {
      final l$phone = data['phone'];
      result$data['phone'] = (l$phone as String?);
    }
    if (data.containsKey('postalCode')) {
      final l$postalCode = data['postalCode'];
      result$data['postalCode'] = (l$postalCode as String?);
    }
    if (data.containsKey('province')) {
      final l$province = data['province'];
      result$data['province'] = (l$province as String?);
    }
    return Input$PersonContactsInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String? get addressLine => (_$data['addressLine'] as String?);

  String? get city => (_$data['city'] as String?);

  String? get email => (_$data['email'] as String?);

  String? get phone => (_$data['phone'] as String?);

  String? get postalCode => (_$data['postalCode'] as String?);

  String? get province => (_$data['province'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('addressLine')) {
      final l$addressLine = addressLine;
      result$data['addressLine'] = l$addressLine;
    }
    if (_$data.containsKey('city')) {
      final l$city = city;
      result$data['city'] = l$city;
    }
    if (_$data.containsKey('email')) {
      final l$email = email;
      result$data['email'] = l$email;
    }
    if (_$data.containsKey('phone')) {
      final l$phone = phone;
      result$data['phone'] = l$phone;
    }
    if (_$data.containsKey('postalCode')) {
      final l$postalCode = postalCode;
      result$data['postalCode'] = l$postalCode;
    }
    if (_$data.containsKey('province')) {
      final l$province = province;
      result$data['province'] = l$province;
    }
    return result$data;
  }

  CopyWith$Input$PersonContactsInput<Input$PersonContactsInput> get copyWith =>
      CopyWith$Input$PersonContactsInput(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$PersonContactsInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$addressLine = addressLine;
    final lOther$addressLine = other.addressLine;
    if (_$data.containsKey('addressLine') !=
        other._$data.containsKey('addressLine')) {
      return false;
    }
    if (l$addressLine != lOther$addressLine) {
      return false;
    }
    final l$city = city;
    final lOther$city = other.city;
    if (_$data.containsKey('city') != other._$data.containsKey('city')) {
      return false;
    }
    if (l$city != lOther$city) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (_$data.containsKey('email') != other._$data.containsKey('email')) {
      return false;
    }
    if (l$email != lOther$email) {
      return false;
    }
    final l$phone = phone;
    final lOther$phone = other.phone;
    if (_$data.containsKey('phone') != other._$data.containsKey('phone')) {
      return false;
    }
    if (l$phone != lOther$phone) {
      return false;
    }
    final l$postalCode = postalCode;
    final lOther$postalCode = other.postalCode;
    if (_$data.containsKey('postalCode') !=
        other._$data.containsKey('postalCode')) {
      return false;
    }
    if (l$postalCode != lOther$postalCode) {
      return false;
    }
    final l$province = province;
    final lOther$province = other.province;
    if (_$data.containsKey('province') !=
        other._$data.containsKey('province')) {
      return false;
    }
    if (l$province != lOther$province) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$addressLine = addressLine;
    final l$city = city;
    final l$email = email;
    final l$phone = phone;
    final l$postalCode = postalCode;
    final l$province = province;
    return Object.hashAll([
      _$data.containsKey('addressLine') ? l$addressLine : const {},
      _$data.containsKey('city') ? l$city : const {},
      _$data.containsKey('email') ? l$email : const {},
      _$data.containsKey('phone') ? l$phone : const {},
      _$data.containsKey('postalCode') ? l$postalCode : const {},
      _$data.containsKey('province') ? l$province : const {},
    ]);
  }
}

abstract class CopyWith$Input$PersonContactsInput<TRes> {
  factory CopyWith$Input$PersonContactsInput(
    Input$PersonContactsInput instance,
    TRes Function(Input$PersonContactsInput) then,
  ) = _CopyWithImpl$Input$PersonContactsInput;

  factory CopyWith$Input$PersonContactsInput.stub(TRes res) =
      _CopyWithStubImpl$Input$PersonContactsInput;

  TRes call({
    String? addressLine,
    String? city,
    String? email,
    String? phone,
    String? postalCode,
    String? province,
  });
}

class _CopyWithImpl$Input$PersonContactsInput<TRes>
    implements CopyWith$Input$PersonContactsInput<TRes> {
  _CopyWithImpl$Input$PersonContactsInput(this._instance, this._then);

  final Input$PersonContactsInput _instance;

  final TRes Function(Input$PersonContactsInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? addressLine = _undefined,
    Object? city = _undefined,
    Object? email = _undefined,
    Object? phone = _undefined,
    Object? postalCode = _undefined,
    Object? province = _undefined,
  }) => _then(
    Input$PersonContactsInput._({
      ..._instance._$data,
      if (addressLine != _undefined) 'addressLine': (addressLine as String?),
      if (city != _undefined) 'city': (city as String?),
      if (email != _undefined) 'email': (email as String?),
      if (phone != _undefined) 'phone': (phone as String?),
      if (postalCode != _undefined) 'postalCode': (postalCode as String?),
      if (province != _undefined) 'province': (province as String?),
    }),
  );
}

class _CopyWithStubImpl$Input$PersonContactsInput<TRes>
    implements CopyWith$Input$PersonContactsInput<TRes> {
  _CopyWithStubImpl$Input$PersonContactsInput(this._res);

  TRes _res;

  call({
    String? addressLine,
    String? city,
    String? email,
    String? phone,
    String? postalCode,
    String? province,
  }) => _res;
}

class Input$PersonImportRow {
  factory Input$PersonImportRow({
    String? addressLine,
    String? birthDate,
    String? birthPlace,
    String? city,
    String? email,
    String? firstName,
    String? gender,
    String? guardianEmail,
    String? guardianFirstName,
    String? guardianLastName,
    String? guardianPhone,
    int? jerseyNumber,
    String? lastName,
    String? phone,
    String? postalCode,
    String? province,
    String? taxCode,
    String? teamName,
  }) => Input$PersonImportRow._({
    if (addressLine != null) r'addressLine': addressLine,
    if (birthDate != null) r'birthDate': birthDate,
    if (birthPlace != null) r'birthPlace': birthPlace,
    if (city != null) r'city': city,
    if (email != null) r'email': email,
    if (firstName != null) r'firstName': firstName,
    if (gender != null) r'gender': gender,
    if (guardianEmail != null) r'guardianEmail': guardianEmail,
    if (guardianFirstName != null) r'guardianFirstName': guardianFirstName,
    if (guardianLastName != null) r'guardianLastName': guardianLastName,
    if (guardianPhone != null) r'guardianPhone': guardianPhone,
    if (jerseyNumber != null) r'jerseyNumber': jerseyNumber,
    if (lastName != null) r'lastName': lastName,
    if (phone != null) r'phone': phone,
    if (postalCode != null) r'postalCode': postalCode,
    if (province != null) r'province': province,
    if (taxCode != null) r'taxCode': taxCode,
    if (teamName != null) r'teamName': teamName,
  });

  Input$PersonImportRow._(this._$data);

  factory Input$PersonImportRow.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('addressLine')) {
      final l$addressLine = data['addressLine'];
      result$data['addressLine'] = (l$addressLine as String?);
    }
    if (data.containsKey('birthDate')) {
      final l$birthDate = data['birthDate'];
      result$data['birthDate'] = (l$birthDate as String?);
    }
    if (data.containsKey('birthPlace')) {
      final l$birthPlace = data['birthPlace'];
      result$data['birthPlace'] = (l$birthPlace as String?);
    }
    if (data.containsKey('city')) {
      final l$city = data['city'];
      result$data['city'] = (l$city as String?);
    }
    if (data.containsKey('email')) {
      final l$email = data['email'];
      result$data['email'] = (l$email as String?);
    }
    if (data.containsKey('firstName')) {
      final l$firstName = data['firstName'];
      result$data['firstName'] = (l$firstName as String?);
    }
    if (data.containsKey('gender')) {
      final l$gender = data['gender'];
      result$data['gender'] = (l$gender as String?);
    }
    if (data.containsKey('guardianEmail')) {
      final l$guardianEmail = data['guardianEmail'];
      result$data['guardianEmail'] = (l$guardianEmail as String?);
    }
    if (data.containsKey('guardianFirstName')) {
      final l$guardianFirstName = data['guardianFirstName'];
      result$data['guardianFirstName'] = (l$guardianFirstName as String?);
    }
    if (data.containsKey('guardianLastName')) {
      final l$guardianLastName = data['guardianLastName'];
      result$data['guardianLastName'] = (l$guardianLastName as String?);
    }
    if (data.containsKey('guardianPhone')) {
      final l$guardianPhone = data['guardianPhone'];
      result$data['guardianPhone'] = (l$guardianPhone as String?);
    }
    if (data.containsKey('jerseyNumber')) {
      final l$jerseyNumber = data['jerseyNumber'];
      result$data['jerseyNumber'] = (l$jerseyNumber as int?);
    }
    if (data.containsKey('lastName')) {
      final l$lastName = data['lastName'];
      result$data['lastName'] = (l$lastName as String?);
    }
    if (data.containsKey('phone')) {
      final l$phone = data['phone'];
      result$data['phone'] = (l$phone as String?);
    }
    if (data.containsKey('postalCode')) {
      final l$postalCode = data['postalCode'];
      result$data['postalCode'] = (l$postalCode as String?);
    }
    if (data.containsKey('province')) {
      final l$province = data['province'];
      result$data['province'] = (l$province as String?);
    }
    if (data.containsKey('taxCode')) {
      final l$taxCode = data['taxCode'];
      result$data['taxCode'] = (l$taxCode as String?);
    }
    if (data.containsKey('teamName')) {
      final l$teamName = data['teamName'];
      result$data['teamName'] = (l$teamName as String?);
    }
    return Input$PersonImportRow._(result$data);
  }

  Map<String, dynamic> _$data;

  String? get addressLine => (_$data['addressLine'] as String?);

  String? get birthDate => (_$data['birthDate'] as String?);

  String? get birthPlace => (_$data['birthPlace'] as String?);

  String? get city => (_$data['city'] as String?);

  String? get email => (_$data['email'] as String?);

  String? get firstName => (_$data['firstName'] as String?);

  String? get gender => (_$data['gender'] as String?);

  String? get guardianEmail => (_$data['guardianEmail'] as String?);

  String? get guardianFirstName => (_$data['guardianFirstName'] as String?);

  String? get guardianLastName => (_$data['guardianLastName'] as String?);

  String? get guardianPhone => (_$data['guardianPhone'] as String?);

  int? get jerseyNumber => (_$data['jerseyNumber'] as int?);

  String? get lastName => (_$data['lastName'] as String?);

  String? get phone => (_$data['phone'] as String?);

  String? get postalCode => (_$data['postalCode'] as String?);

  String? get province => (_$data['province'] as String?);

  String? get taxCode => (_$data['taxCode'] as String?);

  String? get teamName => (_$data['teamName'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('addressLine')) {
      final l$addressLine = addressLine;
      result$data['addressLine'] = l$addressLine;
    }
    if (_$data.containsKey('birthDate')) {
      final l$birthDate = birthDate;
      result$data['birthDate'] = l$birthDate;
    }
    if (_$data.containsKey('birthPlace')) {
      final l$birthPlace = birthPlace;
      result$data['birthPlace'] = l$birthPlace;
    }
    if (_$data.containsKey('city')) {
      final l$city = city;
      result$data['city'] = l$city;
    }
    if (_$data.containsKey('email')) {
      final l$email = email;
      result$data['email'] = l$email;
    }
    if (_$data.containsKey('firstName')) {
      final l$firstName = firstName;
      result$data['firstName'] = l$firstName;
    }
    if (_$data.containsKey('gender')) {
      final l$gender = gender;
      result$data['gender'] = l$gender;
    }
    if (_$data.containsKey('guardianEmail')) {
      final l$guardianEmail = guardianEmail;
      result$data['guardianEmail'] = l$guardianEmail;
    }
    if (_$data.containsKey('guardianFirstName')) {
      final l$guardianFirstName = guardianFirstName;
      result$data['guardianFirstName'] = l$guardianFirstName;
    }
    if (_$data.containsKey('guardianLastName')) {
      final l$guardianLastName = guardianLastName;
      result$data['guardianLastName'] = l$guardianLastName;
    }
    if (_$data.containsKey('guardianPhone')) {
      final l$guardianPhone = guardianPhone;
      result$data['guardianPhone'] = l$guardianPhone;
    }
    if (_$data.containsKey('jerseyNumber')) {
      final l$jerseyNumber = jerseyNumber;
      result$data['jerseyNumber'] = l$jerseyNumber;
    }
    if (_$data.containsKey('lastName')) {
      final l$lastName = lastName;
      result$data['lastName'] = l$lastName;
    }
    if (_$data.containsKey('phone')) {
      final l$phone = phone;
      result$data['phone'] = l$phone;
    }
    if (_$data.containsKey('postalCode')) {
      final l$postalCode = postalCode;
      result$data['postalCode'] = l$postalCode;
    }
    if (_$data.containsKey('province')) {
      final l$province = province;
      result$data['province'] = l$province;
    }
    if (_$data.containsKey('taxCode')) {
      final l$taxCode = taxCode;
      result$data['taxCode'] = l$taxCode;
    }
    if (_$data.containsKey('teamName')) {
      final l$teamName = teamName;
      result$data['teamName'] = l$teamName;
    }
    return result$data;
  }

  CopyWith$Input$PersonImportRow<Input$PersonImportRow> get copyWith =>
      CopyWith$Input$PersonImportRow(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$PersonImportRow || runtimeType != other.runtimeType) {
      return false;
    }
    final l$addressLine = addressLine;
    final lOther$addressLine = other.addressLine;
    if (_$data.containsKey('addressLine') !=
        other._$data.containsKey('addressLine')) {
      return false;
    }
    if (l$addressLine != lOther$addressLine) {
      return false;
    }
    final l$birthDate = birthDate;
    final lOther$birthDate = other.birthDate;
    if (_$data.containsKey('birthDate') !=
        other._$data.containsKey('birthDate')) {
      return false;
    }
    if (l$birthDate != lOther$birthDate) {
      return false;
    }
    final l$birthPlace = birthPlace;
    final lOther$birthPlace = other.birthPlace;
    if (_$data.containsKey('birthPlace') !=
        other._$data.containsKey('birthPlace')) {
      return false;
    }
    if (l$birthPlace != lOther$birthPlace) {
      return false;
    }
    final l$city = city;
    final lOther$city = other.city;
    if (_$data.containsKey('city') != other._$data.containsKey('city')) {
      return false;
    }
    if (l$city != lOther$city) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (_$data.containsKey('email') != other._$data.containsKey('email')) {
      return false;
    }
    if (l$email != lOther$email) {
      return false;
    }
    final l$firstName = firstName;
    final lOther$firstName = other.firstName;
    if (_$data.containsKey('firstName') !=
        other._$data.containsKey('firstName')) {
      return false;
    }
    if (l$firstName != lOther$firstName) {
      return false;
    }
    final l$gender = gender;
    final lOther$gender = other.gender;
    if (_$data.containsKey('gender') != other._$data.containsKey('gender')) {
      return false;
    }
    if (l$gender != lOther$gender) {
      return false;
    }
    final l$guardianEmail = guardianEmail;
    final lOther$guardianEmail = other.guardianEmail;
    if (_$data.containsKey('guardianEmail') !=
        other._$data.containsKey('guardianEmail')) {
      return false;
    }
    if (l$guardianEmail != lOther$guardianEmail) {
      return false;
    }
    final l$guardianFirstName = guardianFirstName;
    final lOther$guardianFirstName = other.guardianFirstName;
    if (_$data.containsKey('guardianFirstName') !=
        other._$data.containsKey('guardianFirstName')) {
      return false;
    }
    if (l$guardianFirstName != lOther$guardianFirstName) {
      return false;
    }
    final l$guardianLastName = guardianLastName;
    final lOther$guardianLastName = other.guardianLastName;
    if (_$data.containsKey('guardianLastName') !=
        other._$data.containsKey('guardianLastName')) {
      return false;
    }
    if (l$guardianLastName != lOther$guardianLastName) {
      return false;
    }
    final l$guardianPhone = guardianPhone;
    final lOther$guardianPhone = other.guardianPhone;
    if (_$data.containsKey('guardianPhone') !=
        other._$data.containsKey('guardianPhone')) {
      return false;
    }
    if (l$guardianPhone != lOther$guardianPhone) {
      return false;
    }
    final l$jerseyNumber = jerseyNumber;
    final lOther$jerseyNumber = other.jerseyNumber;
    if (_$data.containsKey('jerseyNumber') !=
        other._$data.containsKey('jerseyNumber')) {
      return false;
    }
    if (l$jerseyNumber != lOther$jerseyNumber) {
      return false;
    }
    final l$lastName = lastName;
    final lOther$lastName = other.lastName;
    if (_$data.containsKey('lastName') !=
        other._$data.containsKey('lastName')) {
      return false;
    }
    if (l$lastName != lOther$lastName) {
      return false;
    }
    final l$phone = phone;
    final lOther$phone = other.phone;
    if (_$data.containsKey('phone') != other._$data.containsKey('phone')) {
      return false;
    }
    if (l$phone != lOther$phone) {
      return false;
    }
    final l$postalCode = postalCode;
    final lOther$postalCode = other.postalCode;
    if (_$data.containsKey('postalCode') !=
        other._$data.containsKey('postalCode')) {
      return false;
    }
    if (l$postalCode != lOther$postalCode) {
      return false;
    }
    final l$province = province;
    final lOther$province = other.province;
    if (_$data.containsKey('province') !=
        other._$data.containsKey('province')) {
      return false;
    }
    if (l$province != lOther$province) {
      return false;
    }
    final l$taxCode = taxCode;
    final lOther$taxCode = other.taxCode;
    if (_$data.containsKey('taxCode') != other._$data.containsKey('taxCode')) {
      return false;
    }
    if (l$taxCode != lOther$taxCode) {
      return false;
    }
    final l$teamName = teamName;
    final lOther$teamName = other.teamName;
    if (_$data.containsKey('teamName') !=
        other._$data.containsKey('teamName')) {
      return false;
    }
    if (l$teamName != lOther$teamName) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$addressLine = addressLine;
    final l$birthDate = birthDate;
    final l$birthPlace = birthPlace;
    final l$city = city;
    final l$email = email;
    final l$firstName = firstName;
    final l$gender = gender;
    final l$guardianEmail = guardianEmail;
    final l$guardianFirstName = guardianFirstName;
    final l$guardianLastName = guardianLastName;
    final l$guardianPhone = guardianPhone;
    final l$jerseyNumber = jerseyNumber;
    final l$lastName = lastName;
    final l$phone = phone;
    final l$postalCode = postalCode;
    final l$province = province;
    final l$taxCode = taxCode;
    final l$teamName = teamName;
    return Object.hashAll([
      _$data.containsKey('addressLine') ? l$addressLine : const {},
      _$data.containsKey('birthDate') ? l$birthDate : const {},
      _$data.containsKey('birthPlace') ? l$birthPlace : const {},
      _$data.containsKey('city') ? l$city : const {},
      _$data.containsKey('email') ? l$email : const {},
      _$data.containsKey('firstName') ? l$firstName : const {},
      _$data.containsKey('gender') ? l$gender : const {},
      _$data.containsKey('guardianEmail') ? l$guardianEmail : const {},
      _$data.containsKey('guardianFirstName') ? l$guardianFirstName : const {},
      _$data.containsKey('guardianLastName') ? l$guardianLastName : const {},
      _$data.containsKey('guardianPhone') ? l$guardianPhone : const {},
      _$data.containsKey('jerseyNumber') ? l$jerseyNumber : const {},
      _$data.containsKey('lastName') ? l$lastName : const {},
      _$data.containsKey('phone') ? l$phone : const {},
      _$data.containsKey('postalCode') ? l$postalCode : const {},
      _$data.containsKey('province') ? l$province : const {},
      _$data.containsKey('taxCode') ? l$taxCode : const {},
      _$data.containsKey('teamName') ? l$teamName : const {},
    ]);
  }
}

abstract class CopyWith$Input$PersonImportRow<TRes> {
  factory CopyWith$Input$PersonImportRow(
    Input$PersonImportRow instance,
    TRes Function(Input$PersonImportRow) then,
  ) = _CopyWithImpl$Input$PersonImportRow;

  factory CopyWith$Input$PersonImportRow.stub(TRes res) =
      _CopyWithStubImpl$Input$PersonImportRow;

  TRes call({
    String? addressLine,
    String? birthDate,
    String? birthPlace,
    String? city,
    String? email,
    String? firstName,
    String? gender,
    String? guardianEmail,
    String? guardianFirstName,
    String? guardianLastName,
    String? guardianPhone,
    int? jerseyNumber,
    String? lastName,
    String? phone,
    String? postalCode,
    String? province,
    String? taxCode,
    String? teamName,
  });
}

class _CopyWithImpl$Input$PersonImportRow<TRes>
    implements CopyWith$Input$PersonImportRow<TRes> {
  _CopyWithImpl$Input$PersonImportRow(this._instance, this._then);

  final Input$PersonImportRow _instance;

  final TRes Function(Input$PersonImportRow) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? addressLine = _undefined,
    Object? birthDate = _undefined,
    Object? birthPlace = _undefined,
    Object? city = _undefined,
    Object? email = _undefined,
    Object? firstName = _undefined,
    Object? gender = _undefined,
    Object? guardianEmail = _undefined,
    Object? guardianFirstName = _undefined,
    Object? guardianLastName = _undefined,
    Object? guardianPhone = _undefined,
    Object? jerseyNumber = _undefined,
    Object? lastName = _undefined,
    Object? phone = _undefined,
    Object? postalCode = _undefined,
    Object? province = _undefined,
    Object? taxCode = _undefined,
    Object? teamName = _undefined,
  }) => _then(
    Input$PersonImportRow._({
      ..._instance._$data,
      if (addressLine != _undefined) 'addressLine': (addressLine as String?),
      if (birthDate != _undefined) 'birthDate': (birthDate as String?),
      if (birthPlace != _undefined) 'birthPlace': (birthPlace as String?),
      if (city != _undefined) 'city': (city as String?),
      if (email != _undefined) 'email': (email as String?),
      if (firstName != _undefined) 'firstName': (firstName as String?),
      if (gender != _undefined) 'gender': (gender as String?),
      if (guardianEmail != _undefined)
        'guardianEmail': (guardianEmail as String?),
      if (guardianFirstName != _undefined)
        'guardianFirstName': (guardianFirstName as String?),
      if (guardianLastName != _undefined)
        'guardianLastName': (guardianLastName as String?),
      if (guardianPhone != _undefined)
        'guardianPhone': (guardianPhone as String?),
      if (jerseyNumber != _undefined) 'jerseyNumber': (jerseyNumber as int?),
      if (lastName != _undefined) 'lastName': (lastName as String?),
      if (phone != _undefined) 'phone': (phone as String?),
      if (postalCode != _undefined) 'postalCode': (postalCode as String?),
      if (province != _undefined) 'province': (province as String?),
      if (taxCode != _undefined) 'taxCode': (taxCode as String?),
      if (teamName != _undefined) 'teamName': (teamName as String?),
    }),
  );
}

class _CopyWithStubImpl$Input$PersonImportRow<TRes>
    implements CopyWith$Input$PersonImportRow<TRes> {
  _CopyWithStubImpl$Input$PersonImportRow(this._res);

  TRes _res;

  call({
    String? addressLine,
    String? birthDate,
    String? birthPlace,
    String? city,
    String? email,
    String? firstName,
    String? gender,
    String? guardianEmail,
    String? guardianFirstName,
    String? guardianLastName,
    String? guardianPhone,
    int? jerseyNumber,
    String? lastName,
    String? phone,
    String? postalCode,
    String? province,
    String? taxCode,
    String? teamName,
  }) => _res;
}

class Input$PersonInput {
  factory Input$PersonInput({
    String? addressLine,
    String? birthDate,
    String? birthPlace,
    List<Enum$PersonCategory>? categories,
    String? city,
    String? email,
    required String firstName,
    Enum$PersonGender? gender,
    required String lastName,
    String? notes,
    String? phone,
    String? postalCode,
    String? province,
    String? taxCode,
  }) => Input$PersonInput._({
    if (addressLine != null) r'addressLine': addressLine,
    if (birthDate != null) r'birthDate': birthDate,
    if (birthPlace != null) r'birthPlace': birthPlace,
    if (categories != null) r'categories': categories,
    if (city != null) r'city': city,
    if (email != null) r'email': email,
    r'firstName': firstName,
    if (gender != null) r'gender': gender,
    r'lastName': lastName,
    if (notes != null) r'notes': notes,
    if (phone != null) r'phone': phone,
    if (postalCode != null) r'postalCode': postalCode,
    if (province != null) r'province': province,
    if (taxCode != null) r'taxCode': taxCode,
  });

  Input$PersonInput._(this._$data);

  factory Input$PersonInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('addressLine')) {
      final l$addressLine = data['addressLine'];
      result$data['addressLine'] = (l$addressLine as String?);
    }
    if (data.containsKey('birthDate')) {
      final l$birthDate = data['birthDate'];
      result$data['birthDate'] = (l$birthDate as String?);
    }
    if (data.containsKey('birthPlace')) {
      final l$birthPlace = data['birthPlace'];
      result$data['birthPlace'] = (l$birthPlace as String?);
    }
    if (data.containsKey('categories')) {
      final l$categories = data['categories'];
      result$data['categories'] = (l$categories as List<dynamic>?)
          ?.map((e) => fromJson$Enum$PersonCategory((e as String)))
          .toList();
    }
    if (data.containsKey('city')) {
      final l$city = data['city'];
      result$data['city'] = (l$city as String?);
    }
    if (data.containsKey('email')) {
      final l$email = data['email'];
      result$data['email'] = (l$email as String?);
    }
    final l$firstName = data['firstName'];
    result$data['firstName'] = (l$firstName as String);
    if (data.containsKey('gender')) {
      final l$gender = data['gender'];
      result$data['gender'] = l$gender == null
          ? null
          : fromJson$Enum$PersonGender((l$gender as String));
    }
    final l$lastName = data['lastName'];
    result$data['lastName'] = (l$lastName as String);
    if (data.containsKey('notes')) {
      final l$notes = data['notes'];
      result$data['notes'] = (l$notes as String?);
    }
    if (data.containsKey('phone')) {
      final l$phone = data['phone'];
      result$data['phone'] = (l$phone as String?);
    }
    if (data.containsKey('postalCode')) {
      final l$postalCode = data['postalCode'];
      result$data['postalCode'] = (l$postalCode as String?);
    }
    if (data.containsKey('province')) {
      final l$province = data['province'];
      result$data['province'] = (l$province as String?);
    }
    if (data.containsKey('taxCode')) {
      final l$taxCode = data['taxCode'];
      result$data['taxCode'] = (l$taxCode as String?);
    }
    return Input$PersonInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String? get addressLine => (_$data['addressLine'] as String?);

  String? get birthDate => (_$data['birthDate'] as String?);

  String? get birthPlace => (_$data['birthPlace'] as String?);

  List<Enum$PersonCategory>? get categories =>
      (_$data['categories'] as List<Enum$PersonCategory>?);

  String? get city => (_$data['city'] as String?);

  String? get email => (_$data['email'] as String?);

  String get firstName => (_$data['firstName'] as String);

  Enum$PersonGender? get gender => (_$data['gender'] as Enum$PersonGender?);

  String get lastName => (_$data['lastName'] as String);

  String? get notes => (_$data['notes'] as String?);

  String? get phone => (_$data['phone'] as String?);

  String? get postalCode => (_$data['postalCode'] as String?);

  String? get province => (_$data['province'] as String?);

  String? get taxCode => (_$data['taxCode'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('addressLine')) {
      final l$addressLine = addressLine;
      result$data['addressLine'] = l$addressLine;
    }
    if (_$data.containsKey('birthDate')) {
      final l$birthDate = birthDate;
      result$data['birthDate'] = l$birthDate;
    }
    if (_$data.containsKey('birthPlace')) {
      final l$birthPlace = birthPlace;
      result$data['birthPlace'] = l$birthPlace;
    }
    if (_$data.containsKey('categories')) {
      final l$categories = categories;
      result$data['categories'] = l$categories
          ?.map((e) => toJson$Enum$PersonCategory(e))
          .toList();
    }
    if (_$data.containsKey('city')) {
      final l$city = city;
      result$data['city'] = l$city;
    }
    if (_$data.containsKey('email')) {
      final l$email = email;
      result$data['email'] = l$email;
    }
    final l$firstName = firstName;
    result$data['firstName'] = l$firstName;
    if (_$data.containsKey('gender')) {
      final l$gender = gender;
      result$data['gender'] = l$gender == null
          ? null
          : toJson$Enum$PersonGender(l$gender);
    }
    final l$lastName = lastName;
    result$data['lastName'] = l$lastName;
    if (_$data.containsKey('notes')) {
      final l$notes = notes;
      result$data['notes'] = l$notes;
    }
    if (_$data.containsKey('phone')) {
      final l$phone = phone;
      result$data['phone'] = l$phone;
    }
    if (_$data.containsKey('postalCode')) {
      final l$postalCode = postalCode;
      result$data['postalCode'] = l$postalCode;
    }
    if (_$data.containsKey('province')) {
      final l$province = province;
      result$data['province'] = l$province;
    }
    if (_$data.containsKey('taxCode')) {
      final l$taxCode = taxCode;
      result$data['taxCode'] = l$taxCode;
    }
    return result$data;
  }

  CopyWith$Input$PersonInput<Input$PersonInput> get copyWith =>
      CopyWith$Input$PersonInput(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$PersonInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$addressLine = addressLine;
    final lOther$addressLine = other.addressLine;
    if (_$data.containsKey('addressLine') !=
        other._$data.containsKey('addressLine')) {
      return false;
    }
    if (l$addressLine != lOther$addressLine) {
      return false;
    }
    final l$birthDate = birthDate;
    final lOther$birthDate = other.birthDate;
    if (_$data.containsKey('birthDate') !=
        other._$data.containsKey('birthDate')) {
      return false;
    }
    if (l$birthDate != lOther$birthDate) {
      return false;
    }
    final l$birthPlace = birthPlace;
    final lOther$birthPlace = other.birthPlace;
    if (_$data.containsKey('birthPlace') !=
        other._$data.containsKey('birthPlace')) {
      return false;
    }
    if (l$birthPlace != lOther$birthPlace) {
      return false;
    }
    final l$categories = categories;
    final lOther$categories = other.categories;
    if (_$data.containsKey('categories') !=
        other._$data.containsKey('categories')) {
      return false;
    }
    if (l$categories != null && lOther$categories != null) {
      if (l$categories.length != lOther$categories.length) {
        return false;
      }
      for (int i = 0; i < l$categories.length; i++) {
        final l$categories$entry = l$categories[i];
        final lOther$categories$entry = lOther$categories[i];
        if (l$categories$entry != lOther$categories$entry) {
          return false;
        }
      }
    } else if (l$categories != lOther$categories) {
      return false;
    }
    final l$city = city;
    final lOther$city = other.city;
    if (_$data.containsKey('city') != other._$data.containsKey('city')) {
      return false;
    }
    if (l$city != lOther$city) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (_$data.containsKey('email') != other._$data.containsKey('email')) {
      return false;
    }
    if (l$email != lOther$email) {
      return false;
    }
    final l$firstName = firstName;
    final lOther$firstName = other.firstName;
    if (l$firstName != lOther$firstName) {
      return false;
    }
    final l$gender = gender;
    final lOther$gender = other.gender;
    if (_$data.containsKey('gender') != other._$data.containsKey('gender')) {
      return false;
    }
    if (l$gender != lOther$gender) {
      return false;
    }
    final l$lastName = lastName;
    final lOther$lastName = other.lastName;
    if (l$lastName != lOther$lastName) {
      return false;
    }
    final l$notes = notes;
    final lOther$notes = other.notes;
    if (_$data.containsKey('notes') != other._$data.containsKey('notes')) {
      return false;
    }
    if (l$notes != lOther$notes) {
      return false;
    }
    final l$phone = phone;
    final lOther$phone = other.phone;
    if (_$data.containsKey('phone') != other._$data.containsKey('phone')) {
      return false;
    }
    if (l$phone != lOther$phone) {
      return false;
    }
    final l$postalCode = postalCode;
    final lOther$postalCode = other.postalCode;
    if (_$data.containsKey('postalCode') !=
        other._$data.containsKey('postalCode')) {
      return false;
    }
    if (l$postalCode != lOther$postalCode) {
      return false;
    }
    final l$province = province;
    final lOther$province = other.province;
    if (_$data.containsKey('province') !=
        other._$data.containsKey('province')) {
      return false;
    }
    if (l$province != lOther$province) {
      return false;
    }
    final l$taxCode = taxCode;
    final lOther$taxCode = other.taxCode;
    if (_$data.containsKey('taxCode') != other._$data.containsKey('taxCode')) {
      return false;
    }
    if (l$taxCode != lOther$taxCode) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$addressLine = addressLine;
    final l$birthDate = birthDate;
    final l$birthPlace = birthPlace;
    final l$categories = categories;
    final l$city = city;
    final l$email = email;
    final l$firstName = firstName;
    final l$gender = gender;
    final l$lastName = lastName;
    final l$notes = notes;
    final l$phone = phone;
    final l$postalCode = postalCode;
    final l$province = province;
    final l$taxCode = taxCode;
    return Object.hashAll([
      _$data.containsKey('addressLine') ? l$addressLine : const {},
      _$data.containsKey('birthDate') ? l$birthDate : const {},
      _$data.containsKey('birthPlace') ? l$birthPlace : const {},
      _$data.containsKey('categories')
          ? l$categories == null
                ? null
                : Object.hashAll(l$categories.map((v) => v))
          : const {},
      _$data.containsKey('city') ? l$city : const {},
      _$data.containsKey('email') ? l$email : const {},
      l$firstName,
      _$data.containsKey('gender') ? l$gender : const {},
      l$lastName,
      _$data.containsKey('notes') ? l$notes : const {},
      _$data.containsKey('phone') ? l$phone : const {},
      _$data.containsKey('postalCode') ? l$postalCode : const {},
      _$data.containsKey('province') ? l$province : const {},
      _$data.containsKey('taxCode') ? l$taxCode : const {},
    ]);
  }
}

abstract class CopyWith$Input$PersonInput<TRes> {
  factory CopyWith$Input$PersonInput(
    Input$PersonInput instance,
    TRes Function(Input$PersonInput) then,
  ) = _CopyWithImpl$Input$PersonInput;

  factory CopyWith$Input$PersonInput.stub(TRes res) =
      _CopyWithStubImpl$Input$PersonInput;

  TRes call({
    String? addressLine,
    String? birthDate,
    String? birthPlace,
    List<Enum$PersonCategory>? categories,
    String? city,
    String? email,
    String? firstName,
    Enum$PersonGender? gender,
    String? lastName,
    String? notes,
    String? phone,
    String? postalCode,
    String? province,
    String? taxCode,
  });
}

class _CopyWithImpl$Input$PersonInput<TRes>
    implements CopyWith$Input$PersonInput<TRes> {
  _CopyWithImpl$Input$PersonInput(this._instance, this._then);

  final Input$PersonInput _instance;

  final TRes Function(Input$PersonInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? addressLine = _undefined,
    Object? birthDate = _undefined,
    Object? birthPlace = _undefined,
    Object? categories = _undefined,
    Object? city = _undefined,
    Object? email = _undefined,
    Object? firstName = _undefined,
    Object? gender = _undefined,
    Object? lastName = _undefined,
    Object? notes = _undefined,
    Object? phone = _undefined,
    Object? postalCode = _undefined,
    Object? province = _undefined,
    Object? taxCode = _undefined,
  }) => _then(
    Input$PersonInput._({
      ..._instance._$data,
      if (addressLine != _undefined) 'addressLine': (addressLine as String?),
      if (birthDate != _undefined) 'birthDate': (birthDate as String?),
      if (birthPlace != _undefined) 'birthPlace': (birthPlace as String?),
      if (categories != _undefined)
        'categories': (categories as List<Enum$PersonCategory>?),
      if (city != _undefined) 'city': (city as String?),
      if (email != _undefined) 'email': (email as String?),
      if (firstName != _undefined && firstName != null)
        'firstName': (firstName as String),
      if (gender != _undefined) 'gender': (gender as Enum$PersonGender?),
      if (lastName != _undefined && lastName != null)
        'lastName': (lastName as String),
      if (notes != _undefined) 'notes': (notes as String?),
      if (phone != _undefined) 'phone': (phone as String?),
      if (postalCode != _undefined) 'postalCode': (postalCode as String?),
      if (province != _undefined) 'province': (province as String?),
      if (taxCode != _undefined) 'taxCode': (taxCode as String?),
    }),
  );
}

class _CopyWithStubImpl$Input$PersonInput<TRes>
    implements CopyWith$Input$PersonInput<TRes> {
  _CopyWithStubImpl$Input$PersonInput(this._res);

  TRes _res;

  call({
    String? addressLine,
    String? birthDate,
    String? birthPlace,
    List<Enum$PersonCategory>? categories,
    String? city,
    String? email,
    String? firstName,
    Enum$PersonGender? gender,
    String? lastName,
    String? notes,
    String? phone,
    String? postalCode,
    String? province,
    String? taxCode,
  }) => _res;
}

class Input$PlayerInput {
  factory Input$PlayerInput({int? jerseyNumber, String? position}) =>
      Input$PlayerInput._({
        if (jerseyNumber != null) r'jerseyNumber': jerseyNumber,
        if (position != null) r'position': position,
      });

  Input$PlayerInput._(this._$data);

  factory Input$PlayerInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('jerseyNumber')) {
      final l$jerseyNumber = data['jerseyNumber'];
      result$data['jerseyNumber'] = (l$jerseyNumber as int?);
    }
    if (data.containsKey('position')) {
      final l$position = data['position'];
      result$data['position'] = (l$position as String?);
    }
    return Input$PlayerInput._(result$data);
  }

  Map<String, dynamic> _$data;

  int? get jerseyNumber => (_$data['jerseyNumber'] as int?);

  String? get position => (_$data['position'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('jerseyNumber')) {
      final l$jerseyNumber = jerseyNumber;
      result$data['jerseyNumber'] = l$jerseyNumber;
    }
    if (_$data.containsKey('position')) {
      final l$position = position;
      result$data['position'] = l$position;
    }
    return result$data;
  }

  CopyWith$Input$PlayerInput<Input$PlayerInput> get copyWith =>
      CopyWith$Input$PlayerInput(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$PlayerInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$jerseyNumber = jerseyNumber;
    final lOther$jerseyNumber = other.jerseyNumber;
    if (_$data.containsKey('jerseyNumber') !=
        other._$data.containsKey('jerseyNumber')) {
      return false;
    }
    if (l$jerseyNumber != lOther$jerseyNumber) {
      return false;
    }
    final l$position = position;
    final lOther$position = other.position;
    if (_$data.containsKey('position') !=
        other._$data.containsKey('position')) {
      return false;
    }
    if (l$position != lOther$position) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$jerseyNumber = jerseyNumber;
    final l$position = position;
    return Object.hashAll([
      _$data.containsKey('jerseyNumber') ? l$jerseyNumber : const {},
      _$data.containsKey('position') ? l$position : const {},
    ]);
  }
}

abstract class CopyWith$Input$PlayerInput<TRes> {
  factory CopyWith$Input$PlayerInput(
    Input$PlayerInput instance,
    TRes Function(Input$PlayerInput) then,
  ) = _CopyWithImpl$Input$PlayerInput;

  factory CopyWith$Input$PlayerInput.stub(TRes res) =
      _CopyWithStubImpl$Input$PlayerInput;

  TRes call({int? jerseyNumber, String? position});
}

class _CopyWithImpl$Input$PlayerInput<TRes>
    implements CopyWith$Input$PlayerInput<TRes> {
  _CopyWithImpl$Input$PlayerInput(this._instance, this._then);

  final Input$PlayerInput _instance;

  final TRes Function(Input$PlayerInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? jerseyNumber = _undefined,
    Object? position = _undefined,
  }) => _then(
    Input$PlayerInput._({
      ..._instance._$data,
      if (jerseyNumber != _undefined) 'jerseyNumber': (jerseyNumber as int?),
      if (position != _undefined) 'position': (position as String?),
    }),
  );
}

class _CopyWithStubImpl$Input$PlayerInput<TRes>
    implements CopyWith$Input$PlayerInput<TRes> {
  _CopyWithStubImpl$Input$PlayerInput(this._res);

  TRes _res;

  call({int? jerseyNumber, String? position}) => _res;
}

class Input$RegisterDeviceInput {
  factory Input$RegisterDeviceInput({
    String? appVersion,
    required Enum$DevicePlatform platform,
    required String token,
  }) => Input$RegisterDeviceInput._({
    if (appVersion != null) r'appVersion': appVersion,
    r'platform': platform,
    r'token': token,
  });

  Input$RegisterDeviceInput._(this._$data);

  factory Input$RegisterDeviceInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('appVersion')) {
      final l$appVersion = data['appVersion'];
      result$data['appVersion'] = (l$appVersion as String?);
    }
    final l$platform = data['platform'];
    result$data['platform'] = fromJson$Enum$DevicePlatform(
      (l$platform as String),
    );
    final l$token = data['token'];
    result$data['token'] = (l$token as String);
    return Input$RegisterDeviceInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String? get appVersion => (_$data['appVersion'] as String?);

  Enum$DevicePlatform get platform =>
      (_$data['platform'] as Enum$DevicePlatform);

  String get token => (_$data['token'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('appVersion')) {
      final l$appVersion = appVersion;
      result$data['appVersion'] = l$appVersion;
    }
    final l$platform = platform;
    result$data['platform'] = toJson$Enum$DevicePlatform(l$platform);
    final l$token = token;
    result$data['token'] = l$token;
    return result$data;
  }

  CopyWith$Input$RegisterDeviceInput<Input$RegisterDeviceInput> get copyWith =>
      CopyWith$Input$RegisterDeviceInput(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$RegisterDeviceInput ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$appVersion = appVersion;
    final lOther$appVersion = other.appVersion;
    if (_$data.containsKey('appVersion') !=
        other._$data.containsKey('appVersion')) {
      return false;
    }
    if (l$appVersion != lOther$appVersion) {
      return false;
    }
    final l$platform = platform;
    final lOther$platform = other.platform;
    if (l$platform != lOther$platform) {
      return false;
    }
    final l$token = token;
    final lOther$token = other.token;
    if (l$token != lOther$token) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$appVersion = appVersion;
    final l$platform = platform;
    final l$token = token;
    return Object.hashAll([
      _$data.containsKey('appVersion') ? l$appVersion : const {},
      l$platform,
      l$token,
    ]);
  }
}

abstract class CopyWith$Input$RegisterDeviceInput<TRes> {
  factory CopyWith$Input$RegisterDeviceInput(
    Input$RegisterDeviceInput instance,
    TRes Function(Input$RegisterDeviceInput) then,
  ) = _CopyWithImpl$Input$RegisterDeviceInput;

  factory CopyWith$Input$RegisterDeviceInput.stub(TRes res) =
      _CopyWithStubImpl$Input$RegisterDeviceInput;

  TRes call({String? appVersion, Enum$DevicePlatform? platform, String? token});
}

class _CopyWithImpl$Input$RegisterDeviceInput<TRes>
    implements CopyWith$Input$RegisterDeviceInput<TRes> {
  _CopyWithImpl$Input$RegisterDeviceInput(this._instance, this._then);

  final Input$RegisterDeviceInput _instance;

  final TRes Function(Input$RegisterDeviceInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? appVersion = _undefined,
    Object? platform = _undefined,
    Object? token = _undefined,
  }) => _then(
    Input$RegisterDeviceInput._({
      ..._instance._$data,
      if (appVersion != _undefined) 'appVersion': (appVersion as String?),
      if (platform != _undefined && platform != null)
        'platform': (platform as Enum$DevicePlatform),
      if (token != _undefined && token != null) 'token': (token as String),
    }),
  );
}

class _CopyWithStubImpl$Input$RegisterDeviceInput<TRes>
    implements CopyWith$Input$RegisterDeviceInput<TRes> {
  _CopyWithStubImpl$Input$RegisterDeviceInput(this._res);

  TRes _res;

  call({String? appVersion, Enum$DevicePlatform? platform, String? token}) =>
      _res;
}

class Input$RegisterInput {
  factory Input$RegisterInput({
    required bool acceptTerms,
    required String email,
    required String fullName,
    String? locale,
    required String password,
  }) => Input$RegisterInput._({
    r'acceptTerms': acceptTerms,
    r'email': email,
    r'fullName': fullName,
    if (locale != null) r'locale': locale,
    r'password': password,
  });

  Input$RegisterInput._(this._$data);

  factory Input$RegisterInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$acceptTerms = data['acceptTerms'];
    result$data['acceptTerms'] = (l$acceptTerms as bool);
    final l$email = data['email'];
    result$data['email'] = (l$email as String);
    final l$fullName = data['fullName'];
    result$data['fullName'] = (l$fullName as String);
    if (data.containsKey('locale')) {
      final l$locale = data['locale'];
      result$data['locale'] = (l$locale as String?);
    }
    final l$password = data['password'];
    result$data['password'] = (l$password as String);
    return Input$RegisterInput._(result$data);
  }

  Map<String, dynamic> _$data;

  bool get acceptTerms => (_$data['acceptTerms'] as bool);

  String get email => (_$data['email'] as String);

  String get fullName => (_$data['fullName'] as String);

  String? get locale => (_$data['locale'] as String?);

  String get password => (_$data['password'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$acceptTerms = acceptTerms;
    result$data['acceptTerms'] = l$acceptTerms;
    final l$email = email;
    result$data['email'] = l$email;
    final l$fullName = fullName;
    result$data['fullName'] = l$fullName;
    if (_$data.containsKey('locale')) {
      final l$locale = locale;
      result$data['locale'] = l$locale;
    }
    final l$password = password;
    result$data['password'] = l$password;
    return result$data;
  }

  CopyWith$Input$RegisterInput<Input$RegisterInput> get copyWith =>
      CopyWith$Input$RegisterInput(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$RegisterInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$acceptTerms = acceptTerms;
    final lOther$acceptTerms = other.acceptTerms;
    if (l$acceptTerms != lOther$acceptTerms) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (l$email != lOther$email) {
      return false;
    }
    final l$fullName = fullName;
    final lOther$fullName = other.fullName;
    if (l$fullName != lOther$fullName) {
      return false;
    }
    final l$locale = locale;
    final lOther$locale = other.locale;
    if (_$data.containsKey('locale') != other._$data.containsKey('locale')) {
      return false;
    }
    if (l$locale != lOther$locale) {
      return false;
    }
    final l$password = password;
    final lOther$password = other.password;
    if (l$password != lOther$password) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$acceptTerms = acceptTerms;
    final l$email = email;
    final l$fullName = fullName;
    final l$locale = locale;
    final l$password = password;
    return Object.hashAll([
      l$acceptTerms,
      l$email,
      l$fullName,
      _$data.containsKey('locale') ? l$locale : const {},
      l$password,
    ]);
  }
}

abstract class CopyWith$Input$RegisterInput<TRes> {
  factory CopyWith$Input$RegisterInput(
    Input$RegisterInput instance,
    TRes Function(Input$RegisterInput) then,
  ) = _CopyWithImpl$Input$RegisterInput;

  factory CopyWith$Input$RegisterInput.stub(TRes res) =
      _CopyWithStubImpl$Input$RegisterInput;

  TRes call({
    bool? acceptTerms,
    String? email,
    String? fullName,
    String? locale,
    String? password,
  });
}

class _CopyWithImpl$Input$RegisterInput<TRes>
    implements CopyWith$Input$RegisterInput<TRes> {
  _CopyWithImpl$Input$RegisterInput(this._instance, this._then);

  final Input$RegisterInput _instance;

  final TRes Function(Input$RegisterInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? acceptTerms = _undefined,
    Object? email = _undefined,
    Object? fullName = _undefined,
    Object? locale = _undefined,
    Object? password = _undefined,
  }) => _then(
    Input$RegisterInput._({
      ..._instance._$data,
      if (acceptTerms != _undefined && acceptTerms != null)
        'acceptTerms': (acceptTerms as bool),
      if (email != _undefined && email != null) 'email': (email as String),
      if (fullName != _undefined && fullName != null)
        'fullName': (fullName as String),
      if (locale != _undefined) 'locale': (locale as String?),
      if (password != _undefined && password != null)
        'password': (password as String),
    }),
  );
}

class _CopyWithStubImpl$Input$RegisterInput<TRes>
    implements CopyWith$Input$RegisterInput<TRes> {
  _CopyWithStubImpl$Input$RegisterInput(this._res);

  TRes _res;

  call({
    bool? acceptTerms,
    String? email,
    String? fullName,
    String? locale,
    String? password,
  }) => _res;
}

class Input$SeasonInput {
  factory Input$SeasonInput({
    required String endsOn,
    required String name,
    required String startsOn,
  }) => Input$SeasonInput._({
    r'endsOn': endsOn,
    r'name': name,
    r'startsOn': startsOn,
  });

  Input$SeasonInput._(this._$data);

  factory Input$SeasonInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$endsOn = data['endsOn'];
    result$data['endsOn'] = (l$endsOn as String);
    final l$name = data['name'];
    result$data['name'] = (l$name as String);
    final l$startsOn = data['startsOn'];
    result$data['startsOn'] = (l$startsOn as String);
    return Input$SeasonInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get endsOn => (_$data['endsOn'] as String);

  String get name => (_$data['name'] as String);

  String get startsOn => (_$data['startsOn'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$endsOn = endsOn;
    result$data['endsOn'] = l$endsOn;
    final l$name = name;
    result$data['name'] = l$name;
    final l$startsOn = startsOn;
    result$data['startsOn'] = l$startsOn;
    return result$data;
  }

  CopyWith$Input$SeasonInput<Input$SeasonInput> get copyWith =>
      CopyWith$Input$SeasonInput(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$SeasonInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$endsOn = endsOn;
    final lOther$endsOn = other.endsOn;
    if (l$endsOn != lOther$endsOn) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$startsOn = startsOn;
    final lOther$startsOn = other.startsOn;
    if (l$startsOn != lOther$startsOn) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$endsOn = endsOn;
    final l$name = name;
    final l$startsOn = startsOn;
    return Object.hashAll([l$endsOn, l$name, l$startsOn]);
  }
}

abstract class CopyWith$Input$SeasonInput<TRes> {
  factory CopyWith$Input$SeasonInput(
    Input$SeasonInput instance,
    TRes Function(Input$SeasonInput) then,
  ) = _CopyWithImpl$Input$SeasonInput;

  factory CopyWith$Input$SeasonInput.stub(TRes res) =
      _CopyWithStubImpl$Input$SeasonInput;

  TRes call({String? endsOn, String? name, String? startsOn});
}

class _CopyWithImpl$Input$SeasonInput<TRes>
    implements CopyWith$Input$SeasonInput<TRes> {
  _CopyWithImpl$Input$SeasonInput(this._instance, this._then);

  final Input$SeasonInput _instance;

  final TRes Function(Input$SeasonInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? endsOn = _undefined,
    Object? name = _undefined,
    Object? startsOn = _undefined,
  }) => _then(
    Input$SeasonInput._({
      ..._instance._$data,
      if (endsOn != _undefined && endsOn != null) 'endsOn': (endsOn as String),
      if (name != _undefined && name != null) 'name': (name as String),
      if (startsOn != _undefined && startsOn != null)
        'startsOn': (startsOn as String),
    }),
  );
}

class _CopyWithStubImpl$Input$SeasonInput<TRes>
    implements CopyWith$Input$SeasonInput<TRes> {
  _CopyWithStubImpl$Input$SeasonInput(this._res);

  TRes _res;

  call({String? endsOn, String? name, String? startsOn}) => _res;
}

class Input$TeamInput {
  factory Input$TeamInput({
    int? birthYearFrom,
    int? birthYearTo,
    String? category,
    String? color,
    required String name,
    required String seasonId,
  }) => Input$TeamInput._({
    if (birthYearFrom != null) r'birthYearFrom': birthYearFrom,
    if (birthYearTo != null) r'birthYearTo': birthYearTo,
    if (category != null) r'category': category,
    if (color != null) r'color': color,
    r'name': name,
    r'seasonId': seasonId,
  });

  Input$TeamInput._(this._$data);

  factory Input$TeamInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('birthYearFrom')) {
      final l$birthYearFrom = data['birthYearFrom'];
      result$data['birthYearFrom'] = (l$birthYearFrom as int?);
    }
    if (data.containsKey('birthYearTo')) {
      final l$birthYearTo = data['birthYearTo'];
      result$data['birthYearTo'] = (l$birthYearTo as int?);
    }
    if (data.containsKey('category')) {
      final l$category = data['category'];
      result$data['category'] = (l$category as String?);
    }
    if (data.containsKey('color')) {
      final l$color = data['color'];
      result$data['color'] = (l$color as String?);
    }
    final l$name = data['name'];
    result$data['name'] = (l$name as String);
    final l$seasonId = data['seasonId'];
    result$data['seasonId'] = (l$seasonId as String);
    return Input$TeamInput._(result$data);
  }

  Map<String, dynamic> _$data;

  int? get birthYearFrom => (_$data['birthYearFrom'] as int?);

  int? get birthYearTo => (_$data['birthYearTo'] as int?);

  String? get category => (_$data['category'] as String?);

  String? get color => (_$data['color'] as String?);

  String get name => (_$data['name'] as String);

  String get seasonId => (_$data['seasonId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('birthYearFrom')) {
      final l$birthYearFrom = birthYearFrom;
      result$data['birthYearFrom'] = l$birthYearFrom;
    }
    if (_$data.containsKey('birthYearTo')) {
      final l$birthYearTo = birthYearTo;
      result$data['birthYearTo'] = l$birthYearTo;
    }
    if (_$data.containsKey('category')) {
      final l$category = category;
      result$data['category'] = l$category;
    }
    if (_$data.containsKey('color')) {
      final l$color = color;
      result$data['color'] = l$color;
    }
    final l$name = name;
    result$data['name'] = l$name;
    final l$seasonId = seasonId;
    result$data['seasonId'] = l$seasonId;
    return result$data;
  }

  CopyWith$Input$TeamInput<Input$TeamInput> get copyWith =>
      CopyWith$Input$TeamInput(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$TeamInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$birthYearFrom = birthYearFrom;
    final lOther$birthYearFrom = other.birthYearFrom;
    if (_$data.containsKey('birthYearFrom') !=
        other._$data.containsKey('birthYearFrom')) {
      return false;
    }
    if (l$birthYearFrom != lOther$birthYearFrom) {
      return false;
    }
    final l$birthYearTo = birthYearTo;
    final lOther$birthYearTo = other.birthYearTo;
    if (_$data.containsKey('birthYearTo') !=
        other._$data.containsKey('birthYearTo')) {
      return false;
    }
    if (l$birthYearTo != lOther$birthYearTo) {
      return false;
    }
    final l$category = category;
    final lOther$category = other.category;
    if (_$data.containsKey('category') !=
        other._$data.containsKey('category')) {
      return false;
    }
    if (l$category != lOther$category) {
      return false;
    }
    final l$color = color;
    final lOther$color = other.color;
    if (_$data.containsKey('color') != other._$data.containsKey('color')) {
      return false;
    }
    if (l$color != lOther$color) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$seasonId = seasonId;
    final lOther$seasonId = other.seasonId;
    if (l$seasonId != lOther$seasonId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$birthYearFrom = birthYearFrom;
    final l$birthYearTo = birthYearTo;
    final l$category = category;
    final l$color = color;
    final l$name = name;
    final l$seasonId = seasonId;
    return Object.hashAll([
      _$data.containsKey('birthYearFrom') ? l$birthYearFrom : const {},
      _$data.containsKey('birthYearTo') ? l$birthYearTo : const {},
      _$data.containsKey('category') ? l$category : const {},
      _$data.containsKey('color') ? l$color : const {},
      l$name,
      l$seasonId,
    ]);
  }
}

abstract class CopyWith$Input$TeamInput<TRes> {
  factory CopyWith$Input$TeamInput(
    Input$TeamInput instance,
    TRes Function(Input$TeamInput) then,
  ) = _CopyWithImpl$Input$TeamInput;

  factory CopyWith$Input$TeamInput.stub(TRes res) =
      _CopyWithStubImpl$Input$TeamInput;

  TRes call({
    int? birthYearFrom,
    int? birthYearTo,
    String? category,
    String? color,
    String? name,
    String? seasonId,
  });
}

class _CopyWithImpl$Input$TeamInput<TRes>
    implements CopyWith$Input$TeamInput<TRes> {
  _CopyWithImpl$Input$TeamInput(this._instance, this._then);

  final Input$TeamInput _instance;

  final TRes Function(Input$TeamInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? birthYearFrom = _undefined,
    Object? birthYearTo = _undefined,
    Object? category = _undefined,
    Object? color = _undefined,
    Object? name = _undefined,
    Object? seasonId = _undefined,
  }) => _then(
    Input$TeamInput._({
      ..._instance._$data,
      if (birthYearFrom != _undefined) 'birthYearFrom': (birthYearFrom as int?),
      if (birthYearTo != _undefined) 'birthYearTo': (birthYearTo as int?),
      if (category != _undefined) 'category': (category as String?),
      if (color != _undefined) 'color': (color as String?),
      if (name != _undefined && name != null) 'name': (name as String),
      if (seasonId != _undefined && seasonId != null)
        'seasonId': (seasonId as String),
    }),
  );
}

class _CopyWithStubImpl$Input$TeamInput<TRes>
    implements CopyWith$Input$TeamInput<TRes> {
  _CopyWithStubImpl$Input$TeamInput(this._res);

  TRes _res;

  call({
    int? birthYearFrom,
    int? birthYearTo,
    String? category,
    String? color,
    String? name,
    String? seasonId,
  }) => _res;
}

class Input$UpdateMeInput {
  factory Input$UpdateMeInput({String? fullName, String? locale}) =>
      Input$UpdateMeInput._({
        if (fullName != null) r'fullName': fullName,
        if (locale != null) r'locale': locale,
      });

  Input$UpdateMeInput._(this._$data);

  factory Input$UpdateMeInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('fullName')) {
      final l$fullName = data['fullName'];
      result$data['fullName'] = (l$fullName as String?);
    }
    if (data.containsKey('locale')) {
      final l$locale = data['locale'];
      result$data['locale'] = (l$locale as String?);
    }
    return Input$UpdateMeInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String? get fullName => (_$data['fullName'] as String?);

  String? get locale => (_$data['locale'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('fullName')) {
      final l$fullName = fullName;
      result$data['fullName'] = l$fullName;
    }
    if (_$data.containsKey('locale')) {
      final l$locale = locale;
      result$data['locale'] = l$locale;
    }
    return result$data;
  }

  CopyWith$Input$UpdateMeInput<Input$UpdateMeInput> get copyWith =>
      CopyWith$Input$UpdateMeInput(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$UpdateMeInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$fullName = fullName;
    final lOther$fullName = other.fullName;
    if (_$data.containsKey('fullName') !=
        other._$data.containsKey('fullName')) {
      return false;
    }
    if (l$fullName != lOther$fullName) {
      return false;
    }
    final l$locale = locale;
    final lOther$locale = other.locale;
    if (_$data.containsKey('locale') != other._$data.containsKey('locale')) {
      return false;
    }
    if (l$locale != lOther$locale) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$fullName = fullName;
    final l$locale = locale;
    return Object.hashAll([
      _$data.containsKey('fullName') ? l$fullName : const {},
      _$data.containsKey('locale') ? l$locale : const {},
    ]);
  }
}

abstract class CopyWith$Input$UpdateMeInput<TRes> {
  factory CopyWith$Input$UpdateMeInput(
    Input$UpdateMeInput instance,
    TRes Function(Input$UpdateMeInput) then,
  ) = _CopyWithImpl$Input$UpdateMeInput;

  factory CopyWith$Input$UpdateMeInput.stub(TRes res) =
      _CopyWithStubImpl$Input$UpdateMeInput;

  TRes call({String? fullName, String? locale});
}

class _CopyWithImpl$Input$UpdateMeInput<TRes>
    implements CopyWith$Input$UpdateMeInput<TRes> {
  _CopyWithImpl$Input$UpdateMeInput(this._instance, this._then);

  final Input$UpdateMeInput _instance;

  final TRes Function(Input$UpdateMeInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? fullName = _undefined, Object? locale = _undefined}) =>
      _then(
        Input$UpdateMeInput._({
          ..._instance._$data,
          if (fullName != _undefined) 'fullName': (fullName as String?),
          if (locale != _undefined) 'locale': (locale as String?),
        }),
      );
}

class _CopyWithStubImpl$Input$UpdateMeInput<TRes>
    implements CopyWith$Input$UpdateMeInput<TRes> {
  _CopyWithStubImpl$Input$UpdateMeInput(this._res);

  TRes _res;

  call({String? fullName, String? locale}) => _res;
}

enum Enum$AuthStatus {
  AUTHENTICATED,
  TWO_FACTOR_REQUIRED,
  $unknown;

  factory Enum$AuthStatus.fromJson(String value) =>
      fromJson$Enum$AuthStatus(value);

  String toJson() => toJson$Enum$AuthStatus(this);
}

String toJson$Enum$AuthStatus(Enum$AuthStatus e) {
  switch (e) {
    case Enum$AuthStatus.AUTHENTICATED:
      return r'AUTHENTICATED';
    case Enum$AuthStatus.TWO_FACTOR_REQUIRED:
      return r'TWO_FACTOR_REQUIRED';
    case Enum$AuthStatus.$unknown:
      return r'$unknown';
  }
}

Enum$AuthStatus fromJson$Enum$AuthStatus(String value) {
  switch (value) {
    case r'AUTHENTICATED':
      return Enum$AuthStatus.AUTHENTICATED;
    case r'TWO_FACTOR_REQUIRED':
      return Enum$AuthStatus.TWO_FACTOR_REQUIRED;
    default:
      return Enum$AuthStatus.$unknown;
  }
}

enum Enum$ConsentKind {
  IMAGE_RELEASE,
  MARKETING,
  PRIVACY_POLICY,
  TERMS_OF_SERVICE,
  $unknown;

  factory Enum$ConsentKind.fromJson(String value) =>
      fromJson$Enum$ConsentKind(value);

  String toJson() => toJson$Enum$ConsentKind(this);
}

String toJson$Enum$ConsentKind(Enum$ConsentKind e) {
  switch (e) {
    case Enum$ConsentKind.IMAGE_RELEASE:
      return r'IMAGE_RELEASE';
    case Enum$ConsentKind.MARKETING:
      return r'MARKETING';
    case Enum$ConsentKind.PRIVACY_POLICY:
      return r'PRIVACY_POLICY';
    case Enum$ConsentKind.TERMS_OF_SERVICE:
      return r'TERMS_OF_SERVICE';
    case Enum$ConsentKind.$unknown:
      return r'$unknown';
  }
}

Enum$ConsentKind fromJson$Enum$ConsentKind(String value) {
  switch (value) {
    case r'IMAGE_RELEASE':
      return Enum$ConsentKind.IMAGE_RELEASE;
    case r'MARKETING':
      return Enum$ConsentKind.MARKETING;
    case r'PRIVACY_POLICY':
      return Enum$ConsentKind.PRIVACY_POLICY;
    case r'TERMS_OF_SERVICE':
      return Enum$ConsentKind.TERMS_OF_SERVICE;
    default:
      return Enum$ConsentKind.$unknown;
  }
}

enum Enum$DevicePlatform {
  ANDROID,
  IOS,
  WEB,
  $unknown;

  factory Enum$DevicePlatform.fromJson(String value) =>
      fromJson$Enum$DevicePlatform(value);

  String toJson() => toJson$Enum$DevicePlatform(this);
}

String toJson$Enum$DevicePlatform(Enum$DevicePlatform e) {
  switch (e) {
    case Enum$DevicePlatform.ANDROID:
      return r'ANDROID';
    case Enum$DevicePlatform.IOS:
      return r'IOS';
    case Enum$DevicePlatform.WEB:
      return r'WEB';
    case Enum$DevicePlatform.$unknown:
      return r'$unknown';
  }
}

Enum$DevicePlatform fromJson$Enum$DevicePlatform(String value) {
  switch (value) {
    case r'ANDROID':
      return Enum$DevicePlatform.ANDROID;
    case r'IOS':
      return Enum$DevicePlatform.IOS;
    case r'WEB':
      return Enum$DevicePlatform.WEB;
    default:
      return Enum$DevicePlatform.$unknown;
  }
}

enum Enum$GuardianRelation {
  FATHER,
  GUARDIAN,
  MOTHER,
  OTHER,
  $unknown;

  factory Enum$GuardianRelation.fromJson(String value) =>
      fromJson$Enum$GuardianRelation(value);

  String toJson() => toJson$Enum$GuardianRelation(this);
}

String toJson$Enum$GuardianRelation(Enum$GuardianRelation e) {
  switch (e) {
    case Enum$GuardianRelation.FATHER:
      return r'FATHER';
    case Enum$GuardianRelation.GUARDIAN:
      return r'GUARDIAN';
    case Enum$GuardianRelation.MOTHER:
      return r'MOTHER';
    case Enum$GuardianRelation.OTHER:
      return r'OTHER';
    case Enum$GuardianRelation.$unknown:
      return r'$unknown';
  }
}

Enum$GuardianRelation fromJson$Enum$GuardianRelation(String value) {
  switch (value) {
    case r'FATHER':
      return Enum$GuardianRelation.FATHER;
    case r'GUARDIAN':
      return Enum$GuardianRelation.GUARDIAN;
    case r'MOTHER':
      return Enum$GuardianRelation.MOTHER;
    case r'OTHER':
      return Enum$GuardianRelation.OTHER;
    default:
      return Enum$GuardianRelation.$unknown;
  }
}

enum Enum$ImportRowStatus {
  CREATE,
  ERROR,
  UPDATE,
  $unknown;

  factory Enum$ImportRowStatus.fromJson(String value) =>
      fromJson$Enum$ImportRowStatus(value);

  String toJson() => toJson$Enum$ImportRowStatus(this);
}

String toJson$Enum$ImportRowStatus(Enum$ImportRowStatus e) {
  switch (e) {
    case Enum$ImportRowStatus.CREATE:
      return r'CREATE';
    case Enum$ImportRowStatus.ERROR:
      return r'ERROR';
    case Enum$ImportRowStatus.UPDATE:
      return r'UPDATE';
    case Enum$ImportRowStatus.$unknown:
      return r'$unknown';
  }
}

Enum$ImportRowStatus fromJson$Enum$ImportRowStatus(String value) {
  switch (value) {
    case r'CREATE':
      return Enum$ImportRowStatus.CREATE;
    case r'ERROR':
      return Enum$ImportRowStatus.ERROR;
    case r'UPDATE':
      return Enum$ImportRowStatus.UPDATE;
    default:
      return Enum$ImportRowStatus.$unknown;
  }
}

enum Enum$MembershipRole {
  ADMIN,
  ATHLETE,
  COACH,
  PARENT,
  SECRETARY,
  SPORTS_DIRECTOR,
  TEAM_MANAGER,
  $unknown;

  factory Enum$MembershipRole.fromJson(String value) =>
      fromJson$Enum$MembershipRole(value);

  String toJson() => toJson$Enum$MembershipRole(this);
}

String toJson$Enum$MembershipRole(Enum$MembershipRole e) {
  switch (e) {
    case Enum$MembershipRole.ADMIN:
      return r'ADMIN';
    case Enum$MembershipRole.ATHLETE:
      return r'ATHLETE';
    case Enum$MembershipRole.COACH:
      return r'COACH';
    case Enum$MembershipRole.PARENT:
      return r'PARENT';
    case Enum$MembershipRole.SECRETARY:
      return r'SECRETARY';
    case Enum$MembershipRole.SPORTS_DIRECTOR:
      return r'SPORTS_DIRECTOR';
    case Enum$MembershipRole.TEAM_MANAGER:
      return r'TEAM_MANAGER';
    case Enum$MembershipRole.$unknown:
      return r'$unknown';
  }
}

Enum$MembershipRole fromJson$Enum$MembershipRole(String value) {
  switch (value) {
    case r'ADMIN':
      return Enum$MembershipRole.ADMIN;
    case r'ATHLETE':
      return Enum$MembershipRole.ATHLETE;
    case r'COACH':
      return Enum$MembershipRole.COACH;
    case r'PARENT':
      return Enum$MembershipRole.PARENT;
    case r'SECRETARY':
      return Enum$MembershipRole.SECRETARY;
    case r'SPORTS_DIRECTOR':
      return Enum$MembershipRole.SPORTS_DIRECTOR;
    case r'TEAM_MANAGER':
      return Enum$MembershipRole.TEAM_MANAGER;
    default:
      return Enum$MembershipRole.$unknown;
  }
}

enum Enum$PersonCategory {
  ATHLETE,
  GUARDIAN,
  MANAGER,
  STAFF,
  VOLUNTEER,
  $unknown;

  factory Enum$PersonCategory.fromJson(String value) =>
      fromJson$Enum$PersonCategory(value);

  String toJson() => toJson$Enum$PersonCategory(this);
}

String toJson$Enum$PersonCategory(Enum$PersonCategory e) {
  switch (e) {
    case Enum$PersonCategory.ATHLETE:
      return r'ATHLETE';
    case Enum$PersonCategory.GUARDIAN:
      return r'GUARDIAN';
    case Enum$PersonCategory.MANAGER:
      return r'MANAGER';
    case Enum$PersonCategory.STAFF:
      return r'STAFF';
    case Enum$PersonCategory.VOLUNTEER:
      return r'VOLUNTEER';
    case Enum$PersonCategory.$unknown:
      return r'$unknown';
  }
}

Enum$PersonCategory fromJson$Enum$PersonCategory(String value) {
  switch (value) {
    case r'ATHLETE':
      return Enum$PersonCategory.ATHLETE;
    case r'GUARDIAN':
      return Enum$PersonCategory.GUARDIAN;
    case r'MANAGER':
      return Enum$PersonCategory.MANAGER;
    case r'STAFF':
      return Enum$PersonCategory.STAFF;
    case r'VOLUNTEER':
      return Enum$PersonCategory.VOLUNTEER;
    default:
      return Enum$PersonCategory.$unknown;
  }
}

enum Enum$PersonGender {
  F,
  M,
  $unknown;

  factory Enum$PersonGender.fromJson(String value) =>
      fromJson$Enum$PersonGender(value);

  String toJson() => toJson$Enum$PersonGender(this);
}

String toJson$Enum$PersonGender(Enum$PersonGender e) {
  switch (e) {
    case Enum$PersonGender.F:
      return r'F';
    case Enum$PersonGender.M:
      return r'M';
    case Enum$PersonGender.$unknown:
      return r'$unknown';
  }
}

Enum$PersonGender fromJson$Enum$PersonGender(String value) {
  switch (value) {
    case r'F':
      return Enum$PersonGender.F;
    case r'M':
      return Enum$PersonGender.M;
    default:
      return Enum$PersonGender.$unknown;
  }
}

enum Enum$PlayerAvailability {
  AVAILABLE,
  INJURED,
  OTHER,
  SUSPENDED,
  $unknown;

  factory Enum$PlayerAvailability.fromJson(String value) =>
      fromJson$Enum$PlayerAvailability(value);

  String toJson() => toJson$Enum$PlayerAvailability(this);
}

String toJson$Enum$PlayerAvailability(Enum$PlayerAvailability e) {
  switch (e) {
    case Enum$PlayerAvailability.AVAILABLE:
      return r'AVAILABLE';
    case Enum$PlayerAvailability.INJURED:
      return r'INJURED';
    case Enum$PlayerAvailability.OTHER:
      return r'OTHER';
    case Enum$PlayerAvailability.SUSPENDED:
      return r'SUSPENDED';
    case Enum$PlayerAvailability.$unknown:
      return r'$unknown';
  }
}

Enum$PlayerAvailability fromJson$Enum$PlayerAvailability(String value) {
  switch (value) {
    case r'AVAILABLE':
      return Enum$PlayerAvailability.AVAILABLE;
    case r'INJURED':
      return Enum$PlayerAvailability.INJURED;
    case r'OTHER':
      return Enum$PlayerAvailability.OTHER;
    case r'SUSPENDED':
      return Enum$PlayerAvailability.SUSPENDED;
    default:
      return Enum$PlayerAvailability.$unknown;
  }
}

enum Enum$SeasonStatus {
  CLOSED,
  OPEN,
  PLANNED,
  $unknown;

  factory Enum$SeasonStatus.fromJson(String value) =>
      fromJson$Enum$SeasonStatus(value);

  String toJson() => toJson$Enum$SeasonStatus(this);
}

String toJson$Enum$SeasonStatus(Enum$SeasonStatus e) {
  switch (e) {
    case Enum$SeasonStatus.CLOSED:
      return r'CLOSED';
    case Enum$SeasonStatus.OPEN:
      return r'OPEN';
    case Enum$SeasonStatus.PLANNED:
      return r'PLANNED';
    case Enum$SeasonStatus.$unknown:
      return r'$unknown';
  }
}

Enum$SeasonStatus fromJson$Enum$SeasonStatus(String value) {
  switch (value) {
    case r'CLOSED':
      return Enum$SeasonStatus.CLOSED;
    case r'OPEN':
      return Enum$SeasonStatus.OPEN;
    case r'PLANNED':
      return Enum$SeasonStatus.PLANNED;
    default:
      return Enum$SeasonStatus.$unknown;
  }
}

enum Enum$StaffRole {
  ASSISTANT_COACH,
  FITNESS_COACH,
  GOALKEEPER_COACH,
  HEAD_COACH,
  TEAM_MANAGER,
  $unknown;

  factory Enum$StaffRole.fromJson(String value) =>
      fromJson$Enum$StaffRole(value);

  String toJson() => toJson$Enum$StaffRole(this);
}

String toJson$Enum$StaffRole(Enum$StaffRole e) {
  switch (e) {
    case Enum$StaffRole.ASSISTANT_COACH:
      return r'ASSISTANT_COACH';
    case Enum$StaffRole.FITNESS_COACH:
      return r'FITNESS_COACH';
    case Enum$StaffRole.GOALKEEPER_COACH:
      return r'GOALKEEPER_COACH';
    case Enum$StaffRole.HEAD_COACH:
      return r'HEAD_COACH';
    case Enum$StaffRole.TEAM_MANAGER:
      return r'TEAM_MANAGER';
    case Enum$StaffRole.$unknown:
      return r'$unknown';
  }
}

Enum$StaffRole fromJson$Enum$StaffRole(String value) {
  switch (value) {
    case r'ASSISTANT_COACH':
      return Enum$StaffRole.ASSISTANT_COACH;
    case r'FITNESS_COACH':
      return Enum$StaffRole.FITNESS_COACH;
    case r'GOALKEEPER_COACH':
      return Enum$StaffRole.GOALKEEPER_COACH;
    case r'HEAD_COACH':
      return Enum$StaffRole.HEAD_COACH;
    case r'TEAM_MANAGER':
      return Enum$StaffRole.TEAM_MANAGER;
    default:
      return Enum$StaffRole.$unknown;
  }
}

enum Enum$__TypeKind {
  SCALAR,
  OBJECT,
  INTERFACE,
  UNION,
  ENUM,
  INPUT_OBJECT,
  LIST,
  NON_NULL,
  $unknown;

  factory Enum$__TypeKind.fromJson(String value) =>
      fromJson$Enum$__TypeKind(value);

  String toJson() => toJson$Enum$__TypeKind(this);
}

String toJson$Enum$__TypeKind(Enum$__TypeKind e) {
  switch (e) {
    case Enum$__TypeKind.SCALAR:
      return r'SCALAR';
    case Enum$__TypeKind.OBJECT:
      return r'OBJECT';
    case Enum$__TypeKind.INTERFACE:
      return r'INTERFACE';
    case Enum$__TypeKind.UNION:
      return r'UNION';
    case Enum$__TypeKind.ENUM:
      return r'ENUM';
    case Enum$__TypeKind.INPUT_OBJECT:
      return r'INPUT_OBJECT';
    case Enum$__TypeKind.LIST:
      return r'LIST';
    case Enum$__TypeKind.NON_NULL:
      return r'NON_NULL';
    case Enum$__TypeKind.$unknown:
      return r'$unknown';
  }
}

Enum$__TypeKind fromJson$Enum$__TypeKind(String value) {
  switch (value) {
    case r'SCALAR':
      return Enum$__TypeKind.SCALAR;
    case r'OBJECT':
      return Enum$__TypeKind.OBJECT;
    case r'INTERFACE':
      return Enum$__TypeKind.INTERFACE;
    case r'UNION':
      return Enum$__TypeKind.UNION;
    case r'ENUM':
      return Enum$__TypeKind.ENUM;
    case r'INPUT_OBJECT':
      return Enum$__TypeKind.INPUT_OBJECT;
    case r'LIST':
      return Enum$__TypeKind.LIST;
    case r'NON_NULL':
      return Enum$__TypeKind.NON_NULL;
    default:
      return Enum$__TypeKind.$unknown;
  }
}

enum Enum$__DirectiveLocation {
  QUERY,
  MUTATION,
  SUBSCRIPTION,
  FIELD,
  FRAGMENT_DEFINITION,
  FRAGMENT_SPREAD,
  INLINE_FRAGMENT,
  VARIABLE_DEFINITION,
  SCHEMA,
  SCALAR,
  OBJECT,
  FIELD_DEFINITION,
  ARGUMENT_DEFINITION,
  INTERFACE,
  UNION,
  ENUM,
  ENUM_VALUE,
  INPUT_OBJECT,
  INPUT_FIELD_DEFINITION,
  $unknown;

  factory Enum$__DirectiveLocation.fromJson(String value) =>
      fromJson$Enum$__DirectiveLocation(value);

  String toJson() => toJson$Enum$__DirectiveLocation(this);
}

String toJson$Enum$__DirectiveLocation(Enum$__DirectiveLocation e) {
  switch (e) {
    case Enum$__DirectiveLocation.QUERY:
      return r'QUERY';
    case Enum$__DirectiveLocation.MUTATION:
      return r'MUTATION';
    case Enum$__DirectiveLocation.SUBSCRIPTION:
      return r'SUBSCRIPTION';
    case Enum$__DirectiveLocation.FIELD:
      return r'FIELD';
    case Enum$__DirectiveLocation.FRAGMENT_DEFINITION:
      return r'FRAGMENT_DEFINITION';
    case Enum$__DirectiveLocation.FRAGMENT_SPREAD:
      return r'FRAGMENT_SPREAD';
    case Enum$__DirectiveLocation.INLINE_FRAGMENT:
      return r'INLINE_FRAGMENT';
    case Enum$__DirectiveLocation.VARIABLE_DEFINITION:
      return r'VARIABLE_DEFINITION';
    case Enum$__DirectiveLocation.SCHEMA:
      return r'SCHEMA';
    case Enum$__DirectiveLocation.SCALAR:
      return r'SCALAR';
    case Enum$__DirectiveLocation.OBJECT:
      return r'OBJECT';
    case Enum$__DirectiveLocation.FIELD_DEFINITION:
      return r'FIELD_DEFINITION';
    case Enum$__DirectiveLocation.ARGUMENT_DEFINITION:
      return r'ARGUMENT_DEFINITION';
    case Enum$__DirectiveLocation.INTERFACE:
      return r'INTERFACE';
    case Enum$__DirectiveLocation.UNION:
      return r'UNION';
    case Enum$__DirectiveLocation.ENUM:
      return r'ENUM';
    case Enum$__DirectiveLocation.ENUM_VALUE:
      return r'ENUM_VALUE';
    case Enum$__DirectiveLocation.INPUT_OBJECT:
      return r'INPUT_OBJECT';
    case Enum$__DirectiveLocation.INPUT_FIELD_DEFINITION:
      return r'INPUT_FIELD_DEFINITION';
    case Enum$__DirectiveLocation.$unknown:
      return r'$unknown';
  }
}

Enum$__DirectiveLocation fromJson$Enum$__DirectiveLocation(String value) {
  switch (value) {
    case r'QUERY':
      return Enum$__DirectiveLocation.QUERY;
    case r'MUTATION':
      return Enum$__DirectiveLocation.MUTATION;
    case r'SUBSCRIPTION':
      return Enum$__DirectiveLocation.SUBSCRIPTION;
    case r'FIELD':
      return Enum$__DirectiveLocation.FIELD;
    case r'FRAGMENT_DEFINITION':
      return Enum$__DirectiveLocation.FRAGMENT_DEFINITION;
    case r'FRAGMENT_SPREAD':
      return Enum$__DirectiveLocation.FRAGMENT_SPREAD;
    case r'INLINE_FRAGMENT':
      return Enum$__DirectiveLocation.INLINE_FRAGMENT;
    case r'VARIABLE_DEFINITION':
      return Enum$__DirectiveLocation.VARIABLE_DEFINITION;
    case r'SCHEMA':
      return Enum$__DirectiveLocation.SCHEMA;
    case r'SCALAR':
      return Enum$__DirectiveLocation.SCALAR;
    case r'OBJECT':
      return Enum$__DirectiveLocation.OBJECT;
    case r'FIELD_DEFINITION':
      return Enum$__DirectiveLocation.FIELD_DEFINITION;
    case r'ARGUMENT_DEFINITION':
      return Enum$__DirectiveLocation.ARGUMENT_DEFINITION;
    case r'INTERFACE':
      return Enum$__DirectiveLocation.INTERFACE;
    case r'UNION':
      return Enum$__DirectiveLocation.UNION;
    case r'ENUM':
      return Enum$__DirectiveLocation.ENUM;
    case r'ENUM_VALUE':
      return Enum$__DirectiveLocation.ENUM_VALUE;
    case r'INPUT_OBJECT':
      return Enum$__DirectiveLocation.INPUT_OBJECT;
    case r'INPUT_FIELD_DEFINITION':
      return Enum$__DirectiveLocation.INPUT_FIELD_DEFINITION;
    default:
      return Enum$__DirectiveLocation.$unknown;
  }
}

const possibleTypesMap = <String, Set<String>>{};
