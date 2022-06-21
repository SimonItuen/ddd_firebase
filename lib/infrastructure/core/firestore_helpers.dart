import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ddd_firebase/domain/auth/i_auth_facade.dart';
import 'package:ddd_firebase/domain/core/errors.dart';
import 'package:ddd_firebase/injection.dart';

extension FirestoreX on FirebaseFirestore {
  Future<DocumentReference> userDocument() async {
    final userOption = await getIt<IAuthFacade>().getSignedInUser();
    final user = userOption.getOrElse(() => throw NoAuthenticatedError());
    return FirebaseFirestore.instance.collection('users').doc(user.id.getOrCrash());
  }
}
extension DocumentReferenceX on DocumentReference{
  CollectionReference get noteCollection => collection('notes');
}
