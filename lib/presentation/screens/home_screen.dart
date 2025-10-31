import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_bloc/presentation/widgets/gradient_appbar.dart';
import '../../logic/task/task_bloc.dart';
import '../../logic/task/task_state.dart';
import '../widgets/add_task_button.dart';
import '../widgets/dismissible_task_card.dart';
import '../widgets/summary_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const CurvedAppBar(title: "My Tasks"),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskLoaded) {
            final tasks = state.tasks;
            final completedCount = tasks.where((t) => t.completed).length;
            final pendingCount = tasks.length - completedCount;

            final date = DateFormat('MMMM dd, yyyy').format(DateTime.now());

            if (tasks.isEmpty) {
              return Center(
                child: Text(
                  "No tasks available",
                  style: TextStyle(fontSize: 16, color: Colors.grey[500]),
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildSummaryTile("Total", tasks.length, Colors.blue),
                            buildSummaryTile("Completed", completedCount, Colors.green),
                            buildSummaryTile("Pending", pendingCount, Colors.orange),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return DismissibleTaskCard(task: task);
                    },
                  ),
                ),
              ],
            );
          } else if (state is TaskError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: const AddTaskButton(),
    );
  }
}


