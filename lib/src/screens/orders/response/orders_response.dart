import 'package:freezed_annotation/freezed_annotation.dart';

part 'orders_response.freezed.dart';

@freezed
class OrdersResponse<T> with _$OrdersResponse<T> {
  factory OrdersResponse.success(T data) = Success;
  factory OrdersResponse.error(String message) = Error;
}
