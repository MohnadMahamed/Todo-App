import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/modules/add_task_screen.dart';
import 'package:to_do_app/shared/components/component.dart';
import 'package:to_do_app/shared/cuibt/cubit.dart';
import 'package:to_do_app/shared/cuibt/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({Key? key}) : super(key: key);

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocConsumer<AppCubit, AppStates>(
            listener: ((context, state) {}),
            builder: (context, state) {
              var completedTasks = AppCubit.get(context).completedTasks;

              return ConditionalBuilder(
                condition: completedTasks.isNotEmpty,
                builder: (context) => SingleChildScrollView(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      Color? colorList() {
                        if ((cubit.completedTasks[index]['color'] ==
                            'colorList.orange')) {
                          return Colors.orange;
                        } else if (cubit.completedTasks[index]['color'] ==
                            'colorList.red') {
                          return Colors.red;
                        } else if (cubit.completedTasks[index]['color'] ==
                            'colorList.brown') {
                          return Colors.brown;
                        } else if (cubit.completedTasks[index]['color'] ==
                            'colorList.blue') {
                          return Colors.blue;
                        }
                        return Colors.black;
                      }

                      return taskItem(
                        onChanged: (bool? value) {
                          showToast(
                              text: (value == true)
                                  ? 'Added to Completed tasks'
                                  : 'Added to Uncompleted tasks',
                              state: ToastStates.success);
                          setState(() {
                            AppCubit.get(context).updateData(
                              isCompleted: (value == true) ? 'true' : 'false',
                              id: cubit.completedTasks[index]['id'],
                              isfav: cubit.allTasks[index]['isFav'].toString(),
                            );
                          });
                        },
                        checkboxColor: colorList(),
                        isCheked: (cubit.completedTasks[index]['isCompleted'] ==
                                'true')
                            ? true
                            : false,
                        title: cubit.completedTasks[index]['title'],
                        dotTap: () {
                          saveAlert(
                              context: context, model: completedTasks[index]);
                          log(cubit.completedTasks[index]['isCompleted']);
                        },
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 5.0,
                    ),
                    itemCount: completedTasks.length,
                  ),
                ),
                fallback: (context) => Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 50.0,
                        ),
                        SizedBox(height: 200.0, width: 200.0, child: emptySvg),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Text(
                          'No tasks to show',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
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
