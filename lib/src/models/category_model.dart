import 'package:freezed_annotation/freezed_annotation.dart';

import 'item_model.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  String title;
  String id;

  @JsonKey(defaultValue: [])
  List<ItemModel> items;

  @JsonKey(defaultValue: 0)
  int pagination;

  CategoryModel({
    required this.title,
    required this.id,
    required this.items,
    required this.pagination,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  @override
  String toString() => 'CategoryModel(title: $title, id: $id)';
}
