

import 'package:ddd_firebase/domain/auth/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class UserObject with _$UserObject {
  const factory UserObject({
    required UniqueId id,



}) = _UserObject;

}