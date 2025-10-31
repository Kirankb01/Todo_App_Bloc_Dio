import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/presentation/widgets/custom_input_field.dart';
import 'package:todo_app_bloc/presentation/widgets/gradient_appbar.dart';
import '../../data/models/task_model.dart';
import '../../logic/task/task_bloc.dart';
import '../../logic/task/task_event.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CurvedAppBar(title: "Add Tasks"),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20,),
            CustomInputField(
              controller: _titleController,
              label: "Task Title",
              hint: "Enter task title",
            ),

            SizedBox(height: 15,),

            CustomInputField(
              controller: _descriptionController,
              label: "Description (optional)",
              hint: "Enter description",
              maxLines: 4,
            ),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_titleController.text.isEmpty) return;

                  final newTask = TaskModel(
                    title: _titleController.text,
                    description: _descriptionController.text.isEmpty
                        ? null
                        : _descriptionController.text,
                  );

                  context.read<TaskBloc>().add(AddTask(newTask));
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.orangeAccent,
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: const Text("Save Task",style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
