import 'package:json_annotation/json_annotation.dart';

import 'cart_item_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  String id;

  DateTime? createdDateTime;

  @JsonKey(name: 'due')
  DateTime overdueDateTime;

  @JsonKey(defaultValue: [])
  List<CartItemModel> items;

  String status;

  @JsonKey(name: 'copiaecola')
  String copyAndPaste;

  double total;

  String qrCodeImage;

  OrderModel({
    required this.id,
    required this.createdDateTime,
    required this.overdueDateTime,
    required this.items,
    required this.status,
    required this.copyAndPaste,
    required this.total,
    required this.qrCodeImage,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  @override
  String toString() {
    return 'OrderModel(id: $id, createdDateTime: $createdDateTime, overdueDateTime: $overdueDateTime, items: $items, status: $status, copyAndPaste: $copyAndPaste, total: $total, qrCodeImage: $qrCodeImage)';
  }
}
