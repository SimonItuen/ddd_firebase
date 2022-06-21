// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UserObject {
  UniqueId get id => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserObjectCopyWith<UserObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserObjectCopyWith<$Res> {
  factory $UserObjectCopyWith(
          UserObject value, $Res Function(UserObject) then) =
      _$UserObjectCopyWithImpl<$Res>;
  $Res call({UniqueId id});
}

/// @nodoc
class _$UserObjectCopyWithImpl<$Res> implements $UserObjectCopyWith<$Res> {
  _$UserObjectCopyWithImpl(this._value, this._then);

  final UserObject _value;
  // ignore: unused_field
  final $Res Function(UserObject) _then;

  @override
  $Res call({
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as UniqueId,
    ));
  }
}

/// @nodoc
abstract class _$$_UserObjectCopyWith<$Res>
    implements $UserObjectCopyWith<$Res> {
  factory _$$_UserObjectCopyWith(
          _$_UserObject value, $Res Function(_$_UserObject) then) =
      __$$_UserObjectCopyWithImpl<$Res>;
  @override
  $Res call({UniqueId id});
}

/// @nodoc
class __$$_UserObjectCopyWithImpl<$Res> extends _$UserObjectCopyWithImpl<$Res>
    implements _$$_UserObjectCopyWith<$Res> {
  __$$_UserObjectCopyWithImpl(
      _$_UserObject _value, $Res Function(_$_UserObject) _then)
      : super(_value, (v) => _then(v as _$_UserObject));

  @override
  _$_UserObject get _value => super._value as _$_UserObject;

  @override
  $Res call({
    Object? id = freezed,
  }) {
    return _then(_$_UserObject(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as UniqueId,
    ));
  }
}

/// @nodoc

class _$_UserObject implements _UserObject {
  const _$_UserObject({required this.id});

  @override
  final UniqueId id;

  @override
  String toString() {
    return 'UserObject(id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserObject &&
            const DeepCollectionEquality().equals(other.id, id));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(id));

  @JsonKey(ignore: true)
  @override
  _$$_UserObjectCopyWith<_$_UserObject> get copyWith =>
      __$$_UserObjectCopyWithImpl<_$_UserObject>(this, _$identity);
}

abstract class _UserObject implements UserObject {
  const factory _UserObject({required final UniqueId id}) = _$_UserObject;

  @override
  UniqueId get id => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_UserObjectCopyWith<_$_UserObject> get copyWith =>
      throw _privateConstructorUsedError;
}
