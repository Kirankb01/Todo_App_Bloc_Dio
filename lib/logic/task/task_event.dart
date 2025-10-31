import '../../data/models/task_model.dart';

abstract class TaskEvent {}
class LoadTasks extends TaskEvent {}
class AddTask extends TaskEvent { final TaskModel task; AddTask(this.task); }
class UpdateTask extends TaskEvent { final TaskModel task; UpdateTask(this.task); }
class DeleteTask extends TaskEvent { final int id; DeleteTask(this.id); }
