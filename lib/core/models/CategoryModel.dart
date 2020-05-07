
import 'package:app_list/core/base/base_model.dart';
import 'package:flutter/material.dart';

class CategoryModel extends BaseModel {
  final String name;
  final Color color;

  CategoryModel(this.name, this.color);

  Map<String, dynamic> toJson() =>
    {
      'name': name,
      'color': color,
    };

  CategoryModel.fromJson(Map<String, dynamic> json)
    : name = json['name'],
      color = json['color'];

  @override
  List<Object> get props => null;

  @override
  bool get stringify => null;

  @override
  Map<String, Object> toMap() {
    return null;
  }
  
}