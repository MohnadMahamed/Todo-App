import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/modules/add_task_screen.dart';
import 'package:to_do_app/shared/components/component.dart';
import 'package:to_do_app/shared/cuibt/cubit.dart';
import 'package:to_do_app/shared/cuibt/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:timezone/data/latest.dart' as tz;

class AllTaskScreen extends StatefulWidget {
  const AllTaskScreen({Key? key}) : super(key: key);

  @override
  State<AllTaskScreen> createState() => _AllTaskScreenState();
}

class _AllTaskScreenState extends State<AllTaskScreen> {
  @override
  void initState() {
    super.initState();

    tz.initializeTimeZones();
  }

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
              var allTasks = AppCubit.get(context).allTasks;

              return ConditionalBuilder(
                condition: allTasks.isNotEmpty,
                builder: (context) => ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    Color? colorList() {
                      if ((cubit.allTasks[index]['color'] ==
                          'colorList.orange')) {
                        return Colors.orange;
                      } else if (cubit.allTasks[index]['color'] ==
                          'colorList.red') {
                        return Colors.red;
                      } else if (cubit.allTasks[index]['color'] ==
                          'colorList.brown') {
                        return Colors.brown;
                      } else if (cubit.allTasks[index]['color'] ==
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
                            id: cubit.allTasks[index]['id'],
                            isfav: cubit.allTasks[index]['isFav'].toString(),
                          );
                        });
                      },
                      checkboxColor: colorList(),
                      isCheked: (cubit.allTasks[index]['isCompleted'] == 'true')
                          ? true
                          : false,
                      title: cubit.allTasks[index]['title'],
                      dotTap: () {
                        saveAlert(context: context, model: allTasks[index]);
                        log(cubit.allTasks[index]['date']);
                      },
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 5.0,
                  ),
                  itemCount: allTasks.length,
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
