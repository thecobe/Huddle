import 'package:gql/ast.dart';

import 'schema.graphql.dart';

class Variables$Mutation$RegisterDevice {
  factory Variables$Mutation$RegisterDevice({
    required Input$RegisterDeviceInput input,
  }) => Variables$Mutation$RegisterDevice._({r'input': input});

  Variables$Mutation$RegisterDevice._(this._$data);

  factory Variables$Mutation$RegisterDevice.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$input = data['input'];
    result$data['input'] = Input$RegisterDeviceInput.fromJson(
      (l$input as Map<String, dynamic>),
    );
    return Variables$Mutation$RegisterDevice._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$RegisterDeviceInput get input =>
      (_$data['input'] as Input$RegisterDeviceInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$RegisterDevice<Variables$Mutation$RegisterDevice>
  get copyWith => CopyWith$Variables$Mutation$RegisterDevice(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$RegisterDevice ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }
}

abstract class CopyWith$Variables$Mutation$RegisterDevice<TRes> {
  factory CopyWith$Variables$Mutation$RegisterDevice(
    Variables$Mutation$RegisterDevice instance,
    TRes Function(Variables$Mutation$RegisterDevice) then,
  ) = _CopyWithImpl$Variables$Mutation$RegisterDevice;

  factory CopyWith$Variables$Mutation$RegisterDevice.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$RegisterDevice;

  TRes call({Input$RegisterDeviceInput? input});
}

class _CopyWithImpl$Variables$Mutation$RegisterDevice<TRes>
    implements CopyWith$Variables$Mutation$RegisterDevice<TRes> {
  _CopyWithImpl$Variables$Mutation$RegisterDevice(this._instance, this._then);

  final Variables$Mutation$RegisterDevice _instance;

  final TRes Function(Variables$Mutation$RegisterDevice) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? input = _undefined}) => _then(
    Variables$Mutation$RegisterDevice._({
      ..._instance._$data,
      if (input != _undefined && input != null)
        'input': (input as Input$RegisterDeviceInput),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$RegisterDevice<TRes>
    implements CopyWith$Variables$Mutation$RegisterDevice<TRes> {
  _CopyWithStubImpl$Variables$Mutation$RegisterDevice(this._res);

  TRes _res;

  call({Input$RegisterDeviceInput? input}) => _res;
}

class Mutation$RegisterDevice {
  Mutation$RegisterDevice({
    required this.registerDevice,
    this.$__typename = 'Mutation',
  });

  factory Mutation$RegisterDevice.fromJson(Map<String, dynamic> json) {
    final l$registerDevice = json['registerDevice'];
    final l$$__typename = json['__typename'];
    return Mutation$RegisterDevice(
      registerDevice: (l$registerDevice as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final bool registerDevice;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$registerDevice = registerDevice;
    _resultData['registerDevice'] = l$registerDevice;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$registerDevice = registerDevice;
    final l$$__typename = $__typename;
    return Object.hashAll([l$registerDevice, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$RegisterDevice || runtimeType != other.runtimeType) {
      return false;
    }
    final l$registerDevice = registerDevice;
    final lOther$registerDevice = other.registerDevice;
    if (l$registerDevice != lOther$registerDevice) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$RegisterDevice on Mutation$RegisterDevice {
  CopyWith$Mutation$RegisterDevice<Mutation$RegisterDevice> get copyWith =>
      CopyWith$Mutation$RegisterDevice(this, (i) => i);
}

abstract class CopyWith$Mutation$RegisterDevice<TRes> {
  factory CopyWith$Mutation$RegisterDevice(
    Mutation$RegisterDevice instance,
    TRes Function(Mutation$RegisterDevice) then,
  ) = _CopyWithImpl$Mutation$RegisterDevice;

  factory CopyWith$Mutation$RegisterDevice.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RegisterDevice;

  TRes call({bool? registerDevice, String? $__typename});
}

class _CopyWithImpl$Mutation$RegisterDevice<TRes>
    implements CopyWith$Mutation$RegisterDevice<TRes> {
  _CopyWithImpl$Mutation$RegisterDevice(this._instance, this._then);

  final Mutation$RegisterDevice _instance;

  final TRes Function(Mutation$RegisterDevice) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? registerDevice = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$RegisterDevice(
      registerDevice: registerDevice == _undefined || registerDevice == null
          ? _instance.registerDevice
          : (registerDevice as bool),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Mutation$RegisterDevice<TRes>
    implements CopyWith$Mutation$RegisterDevice<TRes> {
  _CopyWithStubImpl$Mutation$RegisterDevice(this._res);

  TRes _res;

  call({bool? registerDevice, String? $__typename}) => _res;
}

const documentNodeMutationRegisterDevice = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'RegisterDevice'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'input')),
          type: NamedTypeNode(
            name: NameNode(value: 'RegisterDeviceInput'),
            isNonNull: true,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'registerDevice'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'input'),
                value: VariableNode(name: NameNode(value: 'input')),
              ),
            ],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ],
      ),
    ),
  ],
);

class Variables$Mutation$UnregisterDevice {
  factory Variables$Mutation$UnregisterDevice({required String token}) =>
      Variables$Mutation$UnregisterDevice._({r'token': token});

  Variables$Mutation$UnregisterDevice._(this._$data);

  factory Variables$Mutation$UnregisterDevice.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$token = data['token'];
    result$data['token'] = (l$token as String);
    return Variables$Mutation$UnregisterDevice._(result$data);
  }

  Map<String, dynamic> _$data;

  String get token => (_$data['token'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$token = token;
    result$data['token'] = l$token;
    return result$data;
  }

  CopyWith$Variables$Mutation$UnregisterDevice<
    Variables$Mutation$UnregisterDevice
  >
  get copyWith => CopyWith$Variables$Mutation$UnregisterDevice(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$UnregisterDevice ||
        runtimeType != other.runtimeType) {
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
    final l$token = token;
    return Object.hashAll([l$token]);
  }
}

abstract class CopyWith$Variables$Mutation$UnregisterDevice<TRes> {
  factory CopyWith$Variables$Mutation$UnregisterDevice(
    Variables$Mutation$UnregisterDevice instance,
    TRes Function(Variables$Mutation$UnregisterDevice) then,
  ) = _CopyWithImpl$Variables$Mutation$UnregisterDevice;

  factory CopyWith$Variables$Mutation$UnregisterDevice.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$UnregisterDevice;

  TRes call({String? token});
}

class _CopyWithImpl$Variables$Mutation$UnregisterDevice<TRes>
    implements CopyWith$Variables$Mutation$UnregisterDevice<TRes> {
  _CopyWithImpl$Variables$Mutation$UnregisterDevice(this._instance, this._then);

  final Variables$Mutation$UnregisterDevice _instance;

  final TRes Function(Variables$Mutation$UnregisterDevice) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? token = _undefined}) => _then(
    Variables$Mutation$UnregisterDevice._({
      ..._instance._$data,
      if (token != _undefined && token != null) 'token': (token as String),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$UnregisterDevice<TRes>
    implements CopyWith$Variables$Mutation$UnregisterDevice<TRes> {
  _CopyWithStubImpl$Variables$Mutation$UnregisterDevice(this._res);

  TRes _res;

  call({String? token}) => _res;
}

class Mutation$UnregisterDevice {
  Mutation$UnregisterDevice({
    required this.unregisterDevice,
    this.$__typename = 'Mutation',
  });

  factory Mutation$UnregisterDevice.fromJson(Map<String, dynamic> json) {
    final l$unregisterDevice = json['unregisterDevice'];
    final l$$__typename = json['__typename'];
    return Mutation$UnregisterDevice(
      unregisterDevice: (l$unregisterDevice as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final bool unregisterDevice;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$unregisterDevice = unregisterDevice;
    _resultData['unregisterDevice'] = l$unregisterDevice;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$unregisterDevice = unregisterDevice;
    final l$$__typename = $__typename;
    return Object.hashAll([l$unregisterDevice, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$UnregisterDevice ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$unregisterDevice = unregisterDevice;
    final lOther$unregisterDevice = other.unregisterDevice;
    if (l$unregisterDevice != lOther$unregisterDevice) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$UnregisterDevice
    on Mutation$UnregisterDevice {
  CopyWith$Mutation$UnregisterDevice<Mutation$UnregisterDevice> get copyWith =>
      CopyWith$Mutation$UnregisterDevice(this, (i) => i);
}

abstract class CopyWith$Mutation$UnregisterDevice<TRes> {
  factory CopyWith$Mutation$UnregisterDevice(
    Mutation$UnregisterDevice instance,
    TRes Function(Mutation$UnregisterDevice) then,
  ) = _CopyWithImpl$Mutation$UnregisterDevice;

  factory CopyWith$Mutation$UnregisterDevice.stub(TRes res) =
      _CopyWithStubImpl$Mutation$UnregisterDevice;

  TRes call({bool? unregisterDevice, String? $__typename});
}

class _CopyWithImpl$Mutation$UnregisterDevice<TRes>
    implements CopyWith$Mutation$UnregisterDevice<TRes> {
  _CopyWithImpl$Mutation$UnregisterDevice(this._instance, this._then);

  final Mutation$UnregisterDevice _instance;

  final TRes Function(Mutation$UnregisterDevice) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? unregisterDevice = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$UnregisterDevice(
      unregisterDevice:
          unregisterDevice == _undefined || unregisterDevice == null
          ? _instance.unregisterDevice
          : (unregisterDevice as bool),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Mutation$UnregisterDevice<TRes>
    implements CopyWith$Mutation$UnregisterDevice<TRes> {
  _CopyWithStubImpl$Mutation$UnregisterDevice(this._res);

  TRes _res;

  call({bool? unregisterDevice, String? $__typename}) => _res;
}

const documentNodeMutationUnregisterDevice = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UnregisterDevice'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'token')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'unregisterDevice'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'token'),
                value: VariableNode(name: NameNode(value: 'token')),
              ),
            ],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ],
      ),
    ),
  ],
);
