import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_response.freezed.dart';

@freezed
class CartResponse<T> with _$CartResponse<T> {
  factory CartResponse.success(T data) = Success;
  factory CartResponse.error(String message) = Error;
}
