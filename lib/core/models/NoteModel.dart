
import 'package:app_list/core/base/base_model.dart';

class NoteModel extends BaseModel {
  final String title;
  final String date;
  final String text;
  final String category;
  final String heroTag;

  NoteModel(this.title, this.date, this.text, this.category, this.heroTag);

  Map<String, dynamic> toJson() =>
    {
      'title': title,
      'date': date,
      'text': text,
      'category': category,
      'heroTag': heroTag,
    };

  NoteModel.fromJson(Map<String, dynamic> json)
    : title = json['title'],
      date = json['date'],
      text = json['text'],
      category = json['category'],
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