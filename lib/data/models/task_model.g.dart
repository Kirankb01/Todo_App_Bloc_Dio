// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
  id: TaskModel._toInt(json['id']),
  title: json['title'] as String,
  description: json['description'] as String?,
  completed: json['completed'] == null
      ? false
      : TaskModel._toBool(json['completed']),
);

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'completed': instance.completed,
};
