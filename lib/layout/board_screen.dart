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
            const Expanded(
              child: DefaultTabController(
                  length: 4,
                  child: Scaffold(
                    appBar: TabBar(
                      isScrollable: true,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.black,
                      unselectedLabelStyle: TextStyle(
                        textBaseline: TextBaseline.ideographic,
                        color: Colors.black45,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                      labelColor: Colors.black,
                      indicatorWeight: 3.0,
                      labelStyle: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      tabs: [
                        Tab(
                          height: 50.0,
                          child: Text(
                            'All',
                          ),
                        ),
                        Tab(
                          height: 50.0,
                          child: Text(
                            'Completed',
                          ),
                        ),
                        Tab(
                          height: 50.0,
                          child: Text(
                            'Uncompleted',
                          ),
                        ),
                        Tab(
                          height: 50.0,
                          child: Text(
                            'Favorite',
                          ),
                        ),
                      ],
                    ),
                    body: TabBarView(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10.0,
                            bottom: 10.0,
                          ),
                          child: AllTaskScreen(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10.0,
                            bottom: 10.0,
                          ),
                          child: CompletedScreen(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10.0,
                            bottom: 10.0,
                          ),
                          child: UnCompletedScreen(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10.0,
                            bottom: 10.0,
                          ),
                          child: FavoriteScreen(),
                        ),
                      ],
                    ),
                  )),
            )
          ],
        ));
  }
}
