import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/task_model.dart';
import '../../data/repositories/task_repository.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repo;

  TaskBloc(this.repo) : super(TaskInitial()) {

    on<LoadTasks>((event, emit) async {
      emit(TaskLoading());
      try {
        final tasks = await repo.getTasks();
        emit(TaskLoaded(tasks));
      } catch (ex) {
        emit(TaskError('Failed to load tasks: $ex'));
      }
    });

    on<AddTask>((event, emit) async {
      if (state is TaskLoaded) {
        final currentTasks = List<TaskModel>.from((state as TaskLoaded).tasks);
        final tempTask = event.task;
        currentTasks.add(tempTask);
        emit(TaskLoaded(currentTasks));

        try {
          final newTask = await repo.addTask(event.task);
          final index = currentTasks.indexWhere((t) => t == tempTask);
          if (index != -1) currentTasks[index] = newTask;
          emit(TaskLoaded(List<TaskModel>.from(currentTasks)));
        } catch (ex) {
          currentTasks.remove(tempTask);
          emit(TaskLoaded(currentTasks));
          emit(TaskError('Failed to add task: $ex'));
        }
      }
    });


    on<UpdateTask>((event, emit) async {
      if (state is TaskLoaded) {
        final currentTasks = List<TaskModel>.from((state as TaskLoaded).tasks);
        final index = currentTasks.indexWhere((t) => t.id == event.task.id);
        if (index == -1) return;

        final oldTask = currentTasks[index];
        currentTasks[index] = event.task;
        emit(TaskLoaded(currentTasks));

        try {
          await repo.editTask(event.task);
        } catch (ex) {
          currentTasks[index] = oldTask;
          emit(TaskLoaded(currentTasks));
          emit(TaskError('Failed to update task: $ex'));
        }
      }
    });


    on<DeleteTask>((event, emit) async {
      if (state is TaskLoaded) {
        final currentTasks = List<TaskModel>.from((state as TaskLoaded).tasks);
        final index = currentTasks.indexWhere((t) => t.id == event.id);
        if (index == -1) return;

        final removedTask = currentTasks.removeAt(index);
        emit(TaskLoaded(currentTasks));

        try {
          await repo.removeTask(event.id);
        } catch (ex) {
          currentTasks.insert(index, removedTask);
          emit(TaskLoaded(currentTasks));
          emit(TaskError('Failed to delete task: $ex'));
        }
      }
    });
  }
}
