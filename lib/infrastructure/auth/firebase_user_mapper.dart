import 'package:ddd_firebase/domain/auth/user.dart';
import 'package:ddd_firebase/domain/auth/value_objects.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension FirebaseUserDomainX on  User{
  UserObject toDomain(){
    return UserObject(id: UniqueId.fromUniqueString(uid));
  }
}