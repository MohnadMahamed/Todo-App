import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/shared/components/component.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:to_do_app/shared/cuibt/cubit.dart';
import 'package:to_do_app/shared/cuibt/states.dart';
import 'package:to_do_app/shared/styles/colors.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime _selectedValue = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          iconSize: 15.0,
          color: Colors.black,
        ),
        title: const Text(
          'Schedule',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          defaultDivider(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: DatePicker(
              DateTime.now(),
              initialSelectedDate: DateTime.now(),
              selectionColor: defaultColor,
              width: 55.0,
              height: 75.0,
              dateTextStyle: const TextStyle(fontSize: 20.0),
              selectedTextColor: Colors.white,
              onDateChange: (date) {
                setState(() {
                  _selectedValue = date;
                });
              },
            ),
          ),
          defaultDivider(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                addTaskText(
                    text: '${DateFormat.EEEE().format(_selectedValue)} '),
                const Spacer(),
                Text(
                  '${DateFormat.yMMMd().format(_selectedValue)} ',
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 20.0, left: 20.0, bottom: 20.0),
                child: BlocConsumer<AppCubit, AppStates>(
                  listener: ((context, state) {}),
                  builder: (context, state) {
                    List allTasks = AppCubit.get(context).allTasks;

                    return ConditionalBuilder(
                      condition: allTasks.isNotEmpty,
                      builder: (context) => ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          Color? colorList() {
                            if (allTasks[index]['color'] ==
                                'ColorList.orange') {
                              return Colors.orange;
                            } else if (allTasks[index]['color'] ==
                                'ColorList.red') {
                              return Colors.red;
                            } else if (allTasks[index]['color'] ==
                                'ColorList.brown') {
                              return Colors.brown;
                            } else if (allTasks[index]['color'] ==
                                'ColorList.blue') {
                              return Colors.blue;
                            }
                            return Colors.black;
                          }

                          if ((allTasks[index]['date'].toString()) ==
                              DateFormat('yyy-MM-dd')
                                  .format(_selectedValue)
                                  .toString()) {
                            return scheduleTaskItem(
                              iconTap: () {
                                showToast(
                                    text: (allTasks[index]['isCompleted'] ==
                                            'true')
                                        ? 'Added to UnCompleted tasks'
                                        : 'Added to Completed tasks',
                                    state: ToastStates.success);

                                AppCubit.get(context).updateData(
                                  isCompleted:
                                      allTasks[index]['isCompleted'] == 'true'
                                          ? 'false'
                                          : 'true',
                                  id: allTasks[index]['id'],
                                  isfav: allTasks[index]['isFav'].toString(),
                                );
                              },
                              color: colorList(),
                              time: allTasks[index]['startTime'],
                              title: allTasks[index]['title'],
                              isCompleted:
                                  (allTasks[index]['isCompleted'] == 'true')
                                      ? true
                                      : false,
                            );
                          } else {
                            return Container(
                              height: 0.0,
                            );
                          }
                        },
                        separatorBuilder: (context, index) {
                          if ((allTasks[index]['date'].toString()) ==
                              DateFormat('yyy-MM-dd')
                                  .format(_selectedValue)
                                  .toString()) {
                            return const SizedBox(height: 10.0);
                          } else {
                            return const SizedBox(
                              height: 0.0,
                            );
                          }
                        },
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
                              SizedBox(
                                  height: 200.0, width: 200.0, child: emptySvg),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
