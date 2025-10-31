import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel {
  @JsonKey(fromJson: _toInt)
  final int? id;

  final String title;
  final String? description;

  @JsonKey(fromJson: _toBool)
  final bool completed;

  TaskModel({
    this.id,
    required this.title,
    this.description,
    this.completed = false,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);


  static int? _toInt(dynamic value) {
    if (value == null) return null;
    return value is int ? value : int.tryParse(value.toString());
  }

  static bool _toBool(dynamic value) {
    if (value is bool) return value;
    if (value is String) return value.toLowerCase() == 'true';
    return false;
  }

  TaskModel copyWith({
    int? id,
    String? title,
    String? description,
    bool? completed,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      completed: completed ?? this.completed,
    );
  }
}
