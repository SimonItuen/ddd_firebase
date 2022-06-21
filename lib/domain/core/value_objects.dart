import 'package:dartz/dartz.dart';
import 'package:ddd_firebase/domain/core/errors.dart';
import 'package:ddd_firebase/domain/core/failures.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();

  Either<ValueFailure<T>, T> get value;

  /// Throws [UnexpectedValueError] containing [ValueFailure]
  getOrCrash() {
    //id = identity - same as writing (right)=> right
    return value.fold(
        (failure) => throw UnexpectedValueError(failure), id);
  }

  bool isValid() => value.isRight();

  Either<ValueFailure<dynamic>, Unit> get failureOrUnit{
      return value.fold((l)=>left(l), (r)=> right(unit));
  }

  @override
  int get hashCode => value.hashCode; //actual value hashcode not referential

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    } //pointing to same memory location then return true

    return other is ValueObject<T> && other.value == value; //have same value
  }

  @override
  String toString() => 'Value($value)';
}
