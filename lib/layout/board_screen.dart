import 'package:flutter/material.dart';
import 'package:to_do_app/modules/all_task_screen.dart';
import 'package:to_do_app/modules/completed_screen.dart';
import 'package:to_do_app/modules/favorite_screen.dart';
import 'package:to_do_app/modules/schedule_screen.dart';
import 'package:to_do_app/modules/un_completed_screen.dart';
import 'package:to_do_app/shared/components/component.dart';

class BoardScreen extends StatelessWidget {
  const BoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: const Text(
            'Board',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: IconButton(
                    onPressed: () {
                      navigateTo(context, const ScheduleScreen());
                    },
                    icon: const Icon(
                      Icons.calendar_today,
                      size: 20.0,
                      color: Colors.black,
                    ))),
          ],
        ),
        body: Column(
          children: [
            defaultDivider(),
            Expanded(
              child: DefaultTabController(
                  length: 4,
                  child: Scaffold(
                    appBar: const TabBar(
                      isScrollable: true,
                      unselectedLabelColor: Colors.grey,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Colors.black,
                      unselectedLabelStyle: TextStyle(
                        color: Colors.black45,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),
                      labelColor: Colors.black,
                      indicatorWeight: 3.0,
                      labelStyle: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      tabs: [
                        Tab(
                          text: 'All',
                        ),
                        Tab(
                          text: 'Completed',
                        ),
                        Tab(
                          text: 'Uncompleted',
                        ),
                        Tab(
                          text: 'Favorite',
                        ),
                      ],
                    ),
                    body: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  color: Colors.black12, width: 2.0))),
                      child: const TabBarView(
                        children: [
                          AllTaskScreen(),
                          CompletedScreen(),
                          UnCompletedScreen(),
                          FavoriteScreen(),
                        ],
                      ),
                    ),
                  )),
            )
          ],
        ));
  }
}
