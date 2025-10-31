import '../../core/api_client.dart';
import '../models/task_model.dart';

class TaskApi {
  final ApiClient client;
  TaskApi(this.client);

  Future<List<TaskModel>> fetchTasks() async {
    final res = await client.get('/todos');
    final List data = res.data as List;
    return data.map((j) => TaskModel.fromJson(j)).toList();
  }

  Future<TaskModel> createTask(TaskModel task) async {
    final res = await client.post('/todos', task.toJson());
    return TaskModel.fromJson(res.data);
  }

  Future<TaskModel> updateTask(TaskModel task) async {
    final res = await client.put('/todos/${task.id}', task.toJson());
    return TaskModel.fromJson(res.data);
  }

  Future<void> deleteTask(int id) async {
    await client.delete('/todos/$id');
  }

  {
    "id":"23",
    "name":"Kiran",
    "age":"21"
    {
      
    }
  }
}
