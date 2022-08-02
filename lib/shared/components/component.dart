import 'dart:developer';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/shared/cuibt/cubit.dart';
import 'package:to_do_app/shared/styles/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_svg/flutter_svg.dart';

void saveAlert({context, model}) {
  final AlertDialog alart = AlertDialog(
    scrollable: true,
    content: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(300.0)),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0), color: Colors.red),
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    AppCubit.get(context).deleteData(id: model['id']);
                    showToast(
                        text: 'Task deleted successfully',
                        state: ToastStates.error);
                  },
                  child: Center(
                    child: Column(
                      children: const [
                        SizedBox(
                          height: 4.0,
                        ),
                        Icon(Icons.delete),
                        SizedBox(
                          height: 2.0,
                        ),
                        Text('Delete',
                            style:
                                TextStyle(color: Colors.black, fontSize: 15.0)),
                        SizedBox(
                          height: 4.0,
                        ),
                      ],
                    ),
                  )),
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          (model['isFav'] == 'false')
              ? Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: defaultColor),
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          AppCubit.get(context).updateData(
                              id: model['id'],
                              isfav: 'true',
                              isCompleted: model['isCompleted']);
                          showToast(
                              text: 'Added to favorite tasks',
                              state: ToastStates.warning);
                        },
                        child: Center(
                          child: Column(
                            children: const [
                              SizedBox(
                                height: 5.0,
                              ),
                              Icon(
                                Icons.favorite,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 2.0,
                              ),
                              Text('Favorite',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                  )),
                              SizedBox(
                                height: 5.0,
                              ),
                            ],
                          ),
                        )),
                  ),
                )
              : Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: defaultColor),
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          AppCubit.get(context).updateData(
                              id: model['id'],
                              isfav: 'false',
                              isCompleted: model['isCompleted']);
                          showToast(
                              text: 'Remove from favorite tasks',
                              state: ToastStates.success);
                        },
                        child: Center(
                          child: Column(
                            children: const [
                              SizedBox(
                                height: 5.0,
                              ),
                              Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 2.0,
                              ),
                              Text('Unfavorite',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                  )),
                              SizedBox(
                                height: 5.0,
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
        ],
      ),
    ),
  );
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return alart;
      });
}

final emptySvg = SvgPicture.asset(
  'assets/empty.svg',
  semanticsLabel: 'No tasks to show',
  cacheColorFilter: true,
  theme:
      const SvgTheme(currentColor: Colors.black, fontSize: 10.0, xHeight: 50.0),
);

void showToast({required String text, required ToastStates state}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER_LEFT,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 15.0,
    );

enum ToastStates { success, error, warning }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = defaultColor;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.teal;
      break;
  }
  return color;
}

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

Widget defaultButton({String? text, void Function()? onPressed}) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20.0),
      child: MaterialButton(
        onPressed: onPressed,
        color: defaultColor,
        textColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        height: 60.0,
        minWidth: double.infinity,
        child: Center(
            child: Text(
          '$text',
          style: const TextStyle(fontWeight: FontWeight.bold),
        )),
      ),
    );

Widget taskItem({
  bool? isCheked,
  context,
  void Function()? dotTap,
  Color? checkboxColor,
  required void Function(bool?)? onChanged,
  Color Function(Set<MaterialState> states)? getColor,
  String? title,
}) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Checkbox(
            value: isCheked,
            activeColor: checkboxColor,
            side: BorderSide(
              color: checkboxColor!,
              width: 2,
            ),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            splashRadius: 20.0,
            onChanged: onChanged,
          ),
          const SizedBox(
            width: 10.0,
          ),
          Text('$title'),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 20.0, bottom: 20.0),
            child: Center(
                child: InkWell(
              onTap: dotTap,
              child: const Text(
                '...',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            )),
          ),
        ],
      ),
    );

Widget pageItem({
  required List taskList,
  required BuildContext context,
}) =>
    ConditionalBuilder(
      condition: taskList.isNotEmpty,
      builder: (context) => ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          Color? colorList() {
            if ((taskList[index]['color'] == 'ColorList.orange')) {
              return Colors.orange;
            } else if (taskList[index]['color'] == 'ColorList.red') {
              return Colors.red;
            } else if (taskList[index]['color'] == 'ColorList.brown') {
              return Colors.brown;
            } else if (taskList[index]['color'] == 'ColorList.blue') {
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

              AppCubit.get(context).updateData(
                isCompleted: (value == true) ? 'true' : 'false',
                id: taskList[index]['id'],
                isfav: taskList[index]['isFav'].toString(),
              );
            },
            checkboxColor: colorList(),
            isCheked: (taskList[index]['isCompleted'] == 'true') ? true : false,
            title: taskList[index]['title'],
            dotTap: () {
              saveAlert(context: context, model: taskList[index]);
              log(taskList[index]['date']);
            },
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: 5.0,
        ),
        itemCount: taskList.length,
      ),
      fallback: (context) => Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 70.0,
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

Widget defaultTextFormFeild(
        {required TextEditingController? controller,
        IconData? suffix,
        required String? hintText,
        TextInputType? type,
        void Function()? onTap,
        required String? Function(String?)? validator}) =>
    Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: SizedBox(
        height: 60.0,
        child: TextFormField(
          style: const TextStyle(
            fontSize: 20.0,
          ),
          controller: controller,
          keyboardType: type,
          onTap: onTap,
          validator: validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[100],
            hintText: '$hintText',
            suffixIcon: Icon(
              suffix,
            ),
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: 15.0,
            ),
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(width: 0.0, color: Colors.white),
            ),
          ),
        ),
      ),
    );

Widget addTaskText({required String? text}) => Text(
      '$text',
      style: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0),
    );

Widget defaultAppBar({required BuildContext context, String? title}) => AppBar(
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
      title: Text(
        '$title',
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );

Widget defaultDivider() => const Divider(
      height: 2.0,
      thickness: 2.0,
    );

Widget scheduleTaskItem(
        {Color? color,
        String? time,
        String? title,
        bool? isCompleted,
        required void Function() iconTap}) =>
    Container(
      height: 80.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$time',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                ),
                const SizedBox(
                  height: 2.0,
                ),
                Text(
                  '$title',
                  style: const TextStyle(color: Colors.white, fontSize: 15.0),
                ),
              ],
            ),
            const Spacer(),
            InkWell(
              onTap: iconTap,
              child: Icon(
                (isCompleted == true)
                    ? Icons.check_circle_outline
                    : Icons.radio_button_unchecked,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );

    // Color? colorList({required List allTasks,required int index}) {
    //                             if (allTasks[index]['color'] ==
    //                                 'ColorList.orange') {
    //                               return Colors.orange;
    //                             } else if (allTasks[index]['color'] ==
    //                                 'ColorList.red') {
    //                               return Colors.red;
    //                             } else if (allTasks[index]['color'] ==
    //                                 'ColorList.brown') {
    //                               return Colors.brown;
    //                             } else if (allTasks[index]['color'] ==
    //                                 'ColorList.blue') {
    //                               return Colors.blue;
    //                             }
    //                             return Colors.black;
    //                           }

