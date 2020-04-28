

import 'package:app_list/core/base/base_model.dart';

class TodoItemModel extends BaseModel {
  final String title;
  final String date;
  final bool completed;
  final String heroTag;

  TodoItemModel(this.title, this.date, this.completed, this.heroTag);

  Map<String, dynamic> toJson() =>
    {
      'title': title,
      'date': date,
      'completed': completed,
      'heroTag': heroTag,
    };

  TodoItemModel.fromJson(Map<String, dynamic> json)
    : title = json['title'],
      date = json['date'],
      completed = json['completed'],
      heroTag = json['heroTag'];

  @override
  List<Object> get props => null;

  @override
  bool get stringify => null;

  @override
  Map<String, Object> toMap() {
    return null;
  }
}