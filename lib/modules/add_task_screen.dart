import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:to_do_app/shared/components/component.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/shared/cuibt/cubit.dart';
import 'package:to_do_app/shared/network/notificationservice.dart';

enum colorList { red, brown, orange, blue }

var titleController = TextEditingController();
var dateController = TextEditingController();
var startTimeController = TextEditingController();
var endTimeController = TextEditingController();
var formKey = GlobalKey<FormState>();

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String dropdownValue = '1 day before';

  colorList? selectedColor = colorList.red;

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);

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
          'Add Task',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            defaultDivider(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addTaskText(text: 'Title'),
                  defaultTextFormFeild(
                      hintText: 'Design team meeting',
                      controller: titleController,
                      type: TextInputType.name,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'please add task title';
                        }

                        return null;
                      }),
                  const SizedBox(
                    height: 10.0,
                  ),
                  addTaskText(text: 'Date'),
                  defaultTextFormFeild(
                    hintText: '2022-07-24',
                    suffix: Icons.keyboard_arrow_down,
                    controller: dateController,
                    type: TextInputType.datetime,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'please add task date';
                      }

                      return null;
                    },
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.parse('2022-12-01'),
                      ).then((DateTime? value) {
                        dateController.text =
                            // DateFormat.yMMMd().format(value!);

                            DateFormat('yyy-MM-dd').format(value!);
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            addTaskText(
                              text: 'Start time',
                            ),
                            defaultTextFormFeild(
                                hintText: '11:00 Am',
                                suffix: Icons.watch_later_outlined,
                                controller: startTimeController,
                                type: TextInputType.datetime,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'please add start time';
                                  }

                                  return null;
                                },
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    startTimeController.text =
                                        value!.format(context);
                                  });
                                })
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            addTaskText(
                              text: 'End time',
                            ),
                            defaultTextFormFeild(
                                hintText: '14:00 Pm',
                                suffix: Icons.watch_later_outlined,
                                controller: endTimeController,
                                type: TextInputType.datetime,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'please add end time';
                                  }

                                  return null;
                                },
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    endTimeController.text =
                                        value!.format(context);
                                  });
                                })
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  addTaskText(text: 'Remind'),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: double.infinity,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: DropdownButton<String>(
                        hint: const Text(
                          'Three',
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        underline: const SizedBox(
                          height: 0.0,
                          width: 0.0,
                        ),
                        value: dropdownValue,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        menuMaxHeight: 200.0,
                        elevation: 10,
                        style: const TextStyle(
                            fontSize: 20.0, color: Colors.black),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: <String>[
                          '1 day before',
                          '1 hour before',
                          '30 min before',
                          '10 min before'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      addTaskText(text: 'Color'),
                      const SizedBox(
                        width: 50.0,
                      ),
                      Expanded(
                        child: Radio<colorList>(
                          activeColor: Colors.red,
                          value: colorList.red,
                          groupValue: selectedColor,
                          onChanged: (colorList? value) {
                            setState(() {
                              selectedColor = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: Radio<colorList>(
                          activeColor: Colors.brown,
                          value: colorList.brown,
                          groupValue: selectedColor,
                          onChanged: (colorList? value) {
                            setState(() {
                              selectedColor = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: Radio<colorList>(
                          activeColor: Colors.orange,
                          value: colorList.orange,
                          groupValue: selectedColor,
                          onChanged: (colorList? value) {
                            setState(() {
                              selectedColor = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: Radio<colorList>(
                          activeColor: Colors.blue,
                          value: colorList.blue,
                          groupValue: selectedColor,
                          onChanged: (colorList? value) {
                            setState(() {
                              selectedColor = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
              child: defaultButton(
                text: 'Create a task',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    NotificationService().scheduledNotification(
                        id: 77,
                        title: 'Time to do Task',
                        body: titleController.text,
                        scheduledDate: DateFormat('yyy-MM-dd hh:mm a').parse(
                            '${dateController.text} ${startTimeController.text}'));

                    cubit.insertToDatabase(
                      title: titleController.text,
                      date: dateController.text,
                      startTime: startTimeController.text,
                      endTime: endTimeController.text,
                      remind: dropdownValue,
                      isCompleted: 'false',
                      isFav: 'false',
                      color: selectedColor.toString(),
                    );
                    titleController.text = '';
                    dateController.text = '';
                    startTimeController.text = '';
                    endTimeController.text = '';

                    Navigator.pop(context);
                    log(selectedColor.toString());
                  }
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
