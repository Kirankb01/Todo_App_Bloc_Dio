import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/task/task_bloc.dart';
import '../../logic/task/task_event.dart';
import '../screens/edit_task_screen.dart';
import 'confirm_dialog.dart';

class DismissibleTaskCard extends StatelessWidget {
  final dynamic task;
  const DismissibleTaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final taskBloc = context.read<TaskBloc>();

    return Dismissible(
      key: Key(task.id.toString()),
      background: Container(
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white, size: 28),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) async {
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (_) => ConfirmDialog(
            title: "Delete Task",
            content: "Are you sure you want to delete this task?",
            confirmText: "Delete",
            cancelText: "Cancel",
          ),
        );
        return confirmed == true;
      },
      onDismissed: (_) => taskBloc.add(DeleteTask(task.id!)),
      child: GestureDetector(
        onTap: () => taskBloc.add(UpdateTask(task.copyWith(completed: !task.completed))),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: task.completed
                ? LinearGradient(
              colors: [Colors.greenAccent.shade100, Colors.green.shade200],
            )
                : LinearGradient(
              colors: [Colors.white, Colors.grey.shade50],
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.08),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: task.completed ? Colors.green : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: task.completed ? Colors.green : Colors.grey.shade400,
                    width: 2,
                  ),
                ),
                child: task.completed
                    ? const Icon(Icons.check, color: Colors.white, size: 18)
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decoration:
                        task.completed ? TextDecoration.lineThrough : null,
                        color: task.completed ? Colors.grey[500] : Colors.black87,
                      ),
                    ),
                    if (task.description != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Text(
                          task.description!,
                          style: TextStyle(
                            fontSize: 14,
                            color: task.completed ? Colors.grey[400] : Colors.grey[700],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blueAccent),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EditTaskScreen(task: task)),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}