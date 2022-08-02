import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/modules/add_task_screen.dart';
import 'package:to_do_app/shared/components/component.dart';
import 'package:to_do_app/shared/cuibt/cubit.dart';
import 'package:to_do_app/shared/cuibt/states.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: BlocConsumer<AppCubit, AppStates>(
                listener: ((context, state) {}),
                builder: (context, state) {
                  var allTasks = AppCubit.get(context).favoriteTasks;

                  return pageItem(taskList: allTasks, context: context);
                },
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          defaultButton(
              text: 'Add a task',
              onPressed: () {
                navigateTo(context, const AddTaskScreen());
              })
        ],
      ),
    );
  }
}
