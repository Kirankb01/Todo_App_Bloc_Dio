import '../data_sources/task_api.dart';
import '../models/task_model.dart';

class TaskRepository {
  final TaskApi api;
  TaskRepository(this.api);

  Future<List<TaskModel>> getTasks() => api.fetchTasks();
  Future<TaskModel> addTask(TaskModel t) => api.createTask(t);
  Future<TaskModel> editTask(TaskModel t) => api.updateTask(t);
  Future<void> removeTask(int id) => api.deleteTask(id);
}


