
import 'package:app_list/core/base/base_model.dart';
import 'package:flutter/material.dart';

class CategoryModel extends BaseModel {
  final String name;
  final Color color;
  final IconData icon;

  CategoryModel({this.name, this.color, this.icon});

  Map<String, dynamic> toJson() =>
    {
      'name': name,
      'color': color.toString(),
      'icon': icon.toString(),
    };

  CategoryModel.fromJson(Map<String, dynamic> json)
    : name = json['name'],
      color = new Color(int.parse(json['color'].split('(0x')[1].split(')')[0], radix: 16)),
      icon = new IconData(int.parse('0x' + json['icon'].split('(U+0')[1].split(')')[0]), 
              fontFamily: 'MaterialIcons');

  @override
  List<Object> get props => null;

  @override
  bool get stringify => null;

  @override
  Map<String, Object> toMap() {
    return null;
  }
  
}