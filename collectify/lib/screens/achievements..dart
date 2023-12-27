import 'package:flutter/material.dart';

class Achievements extends StatefulWidget {
  const Achievements({super.key});

  @override
  State<Achievements> createState() => _AchievementsState();
}

class _AchievementsState extends State<Achievements> {
  final List<String> achievementList = [
    "Achievement 1",
    "Achievement 2",
    "Achievement 3",
    "Achievement 4",
    "Achievement 5",
    "Achievement 6",
    "Achievement 7",
    "Achievement 8",
    "Achievement 9",
    "Achievement 10",
    "Achievement 11",
    "Achievement 12",
    "Achievement 13",
    "Achievement 14",
    "Achievement 15",
    "Achievement 16",
    "Achievement 17",
    "Achievement 18",
    "Achievement 19",
    "Achievement 20",
    "Achievement 21",
    "Achievement 22",
    "Achievement 23",
    "Achievement 24",
    "Achievement 25",
    "Achievement 26",
    "Achievement 27",
    "Achievement 28",
    "Achievement 29",
    "Achievement 30",
  ];
  List<int> isAchieved = [
    1,
    0,
    0,
    0,
    1,
    1,
    1,
    0,
    0,
    1,
    0,
    1,
    1,
    0,
    0,
    1,
    0,
    0,
    0,
    1,
    1,
    1,
    0,
    0,
    1,
    0,
    1,
    1,
    0,
    0
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // bottomNavigationBar: myBottomNavigationBar(),
      appBar: AppBar(
        title: const Text("Achievements"),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20.0, right: 10, left: 10, bottom: 20),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
          ),
          itemCount: 30,
          itemBuilder: (context, index) {
            if (isAchieved[index] == 0) {
              return AchievedWidget(
                  achievementList: achievementList, index: index);
            } else {
              return UnachievedWidget(
                  achievementList: achievementList, index: index);
            }
          },
        ),
      ),
    );
  }
}

class AchievedWidget extends StatelessWidget {
  const AchievedWidget(
      {super.key, required this.achievementList, required this.index});

  final List<String> achievementList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage('images/achievement.png'),
          radius: 30,
        ),
        const SizedBox(
          height: 5,
        ),
        Text('${achievementList[index]}'),
      ],
    );
  }
}

class UnachievedWidget extends StatelessWidget {
  const UnachievedWidget(
      {super.key, required this.achievementList, required this.index});

  final List<String> achievementList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage('images/achievement_grey.png'),
          radius: 30,
        ),
        const SizedBox(
          height: 5,
        ),
        Text('${achievementList[index]}'),
      ],
    );
  }
}
