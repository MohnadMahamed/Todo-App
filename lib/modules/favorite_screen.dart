import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/modules/add_task_screen.dart';
import 'package:to_do_app/shared/components/component.dart';
import 'package:to_do_app/shared/cuibt/cubit.dart';
import 'package:to_do_app/shared/cuibt/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
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
              var favoriteTasks = AppCubit.get(context).favoriteTasks;

              return ConditionalBuilder(
                condition: favoriteTasks.isNotEmpty,
                builder: (context) => SingleChildScrollView(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      Color? colorList() {
                        if ((cubit.favoriteTasks[index]['color'] ==
                            'colorList.orange')) {
                          return Colors.orange;
                        } else if (cubit.favoriteTasks[index]['color'] ==
                            'colorList.red') {
                          return Colors.red;
                        } else if (cubit.favoriteTasks[index]['color'] ==
                            'colorList.brown') {
                          return Colors.brown;
                        } else if (cubit.favoriteTasks[index]['color'] ==
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
                              id: cubit.favoriteTasks[index]['id'],
                              isfav: cubit.allTasks[index]['isFav'].toString(),
                            );
                          });
                        },
                        checkboxColor: colorList(),
                        isCheked: (cubit.favoriteTasks[index]['isCompleted'] ==
                                'true')
                            ? true
                            : false,
                        title: cubit.favoriteTasks[index]['title'],
                        dotTap: () {
                          saveAlert(
                              context: context, model: favoriteTasks[index]);
                          log(cubit.favoriteTasks[index]['isCompleted']);
                        },
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 5.0,
                    ),
                    itemCount: favoriteTasks.length,
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
