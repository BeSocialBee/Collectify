// import 'dart:async';
// import 'package:go_router/go_router.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'dart:math';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class DailySpin extends StatefulWidget {
//   DailySpin({Key? key}) : super(key: key);
//   @override
//   _DailySpinState createState() => _DailySpinState();
// }

// class _DailySpinState extends State<DailySpin> {
//   late Future<Map<String, dynamic>> user;
//   late StreamController<num> _countdownStreamController;

//   Future<void> _init(user) async {
//     try {
//       Map<String, dynamic> userr = await user;
//       await calculateRemainingTime(userr);
//     } catch (e) {
//       // Handle errors
//       print('Error: $e');
//     }
//   }

//   Future<void> calculateRemainingTime(user) async {
//     try {
//       String endingTimeString = user['spinAvailable'];
//       List<String> dateTimeParts = endingTimeString.split('T');
//       List<String> dateParts = dateTimeParts[0].split('.');
//       List<String> timeParts = dateTimeParts[1].split(':');
//       int year = int.parse(dateParts[2]);
//       int month = int.parse(dateParts[1]);
//       int day = int.parse(dateParts[0]);
//       int hour = int.parse(timeParts[0]);
//       int minute = int.parse(timeParts[1]);
//       int second = int.parse(timeParts[2]);
//       DateTime endingTime = DateTime(year, month, day, hour, minute, second);
//       Duration remainingTime = endingTime.difference(DateTime.now());
//       final Timer timer = Timer.periodic(Duration(seconds: 1), (timer) {
//         num secondsRemaining = remainingTime.inSeconds;

//         // Check if the stream is closed before adding an event
//         if (!_countdownStreamController.isClosed) {
//           // If the countdown is finished, close the stream
//           if (secondsRemaining <= 0.0) {
//             _countdownStreamController.close();
//             timer.cancel();

//             //endAuction(documentID); -> burda spiinn
//           } else {
//             // Update the UI with the remaining time
//             _countdownStreamController.add(secondsRemaining);
//             remainingTime = remainingTime - Duration(seconds: 1);
//           }
//         } else {
//           // Stream is closed, cancel the timer
//           timer.cancel();
//         }
//       });
//     } catch (e) {
//       // Handle errors
//       print('Error eeeeeeeee: $e');
//     }
//   }

//   Future<Map<String, dynamic>> getUser() async {
//     try {
//       //var userID = await SharedPreferencesUtil.loadUserIdFromLocalStorage();
//       var userID = "luK4dXzgq9eVH7ZL0NczLWCxe8J3";

//       String apiUrl =
//           'https://z725a0ie1j.execute-api.us-east-1.amazonaws.com/userStage/getUser';
//       var response = await http.post(
//         Uri.parse(apiUrl),
//         body: {
//           'userID': userID,
//         },
//       );

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
//         final Map<String, dynamic> jsonArray = jsonResponse['userData'] ?? {};
//         return jsonArray;
//       } else {
//         print('Error response: ${response.statusCode}');
//         throw Exception('Failed to get user data');
//       }
//     } catch (e) {
//       print('Error loading profile: $e');
//       throw Exception('Failed to get user data');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _countdownStreamController = StreamController<num>();
//     user = getUser();
//     _init(user);
//   }

//   @override
//   void dispose() {
//     // Close the stream controller when the widget is disposed
//     _countdownStreamController.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

// class FortuneWheelPage extends HookWidget {
//   static const kRouteName = 'FortuneWheelPage';

//   static void go(BuildContext context) {
//     context.goNamed(kRouteName);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final alignment = useState(Alignment.topCenter);
//     final selected = useStreamController<int>();
//     final selectedIndex = useStream(selected.stream, initialData: 0).data ?? 0;
//     final isAnimating = useState(false);

//     void handleRoll() {
//       selected.add(
//         roll(Constants.fortuneValues.length),
//       );
//     }
//     if(1 == 1)
//       return LayoutWithButton(selectedIndex: selectedIndex, isAnimating: isAnimating, alignment: alignment, selected: selected);
//     else   
//       return LayoutWithButton(selectedIndex: selectedIndex, isAnimating: isAnimating, alignment: alignment, selected: selected);
//   }
// }

// class LayoutWithButton extends StatelessWidget {
//   const LayoutWithButton({
//     super.key,
//     required this.selectedIndex,
//     required this.isAnimating,
//     required this.alignment,
//     required this.selected,
//   });

//   final int selectedIndex;
//   final ValueNotifier<bool> isAnimating;
//   final ValueNotifier<Alignment> alignment;
//   final StreamController<int> selected;
  

//   @override
//   Widget build(BuildContext context) {
//     void handleRoll() {
//       selected.add(
//         roll(Constants.fortuneValues.length),
//       );
//     }
//     return AppLayout(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             SizedBox(height: 8),
//             SizedBox(height: 8),
//             RollButtonWithPreview(
//               selected: selectedIndex,
//               items: Constants.fortuneValues,
//               onPressed: isAnimating.value ? null : handleRoll,
//             ),
//             Expanded(
//               child: FortuneWheel(
//                 animateFirst: false,
//                 alignment: alignment.value,
//                 selected: selected.stream,
//                 onAnimationStart: () => isAnimating.value = true,
//                 onAnimationEnd: () => isAnimating.value = false,
//                 onFling: handleRoll,
//                 hapticImpact: HapticImpact.heavy,
//                 indicators: [
//                   FortuneIndicator(
//                     alignment: alignment.value,
//                     child: TriangleIndicator(),
//                   ),
//                 ],
//                 items: [
//                   for (var it in Constants.fortuneValues)
//                     FortuneItem(child: Text(it), onTap: () => print(it))
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }class LayoutWithTimer extends StatelessWidget {
//   const LayoutWithTimer({
//     super.key,
//     required this.selectedIndex,
//     required this.isAnimating,
//     required this.alignment,
//     required this.selected,
//   });

//   final int selectedIndex;
//   final ValueNotifier<bool> isAnimating;
//   final ValueNotifier<Alignment> alignment;
//   final StreamController<int> selected;

//   @override
//   Widget build(BuildContext context) {
//     void handleRoll() {
//       selected.add(
//         roll(Constants.fortuneValues.length),
//       );
//     }
//     return AppLayout(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             SizedBox(height: 8),
//             DailyCountdown(),
//             SizedBox(height: 8),
//             Expanded(
//               child: FortuneWheel(
//                 animateFirst: false,
//                 alignment: alignment.value,
//                 selected: selected.stream,
//                 onAnimationStart: () => isAnimating.value = true,
//                 onAnimationEnd: () => isAnimating.value = false,
//                 onFling: handleRoll,
//                 hapticImpact: HapticImpact.heavy,
//                 indicators: [
//                   FortuneIndicator(
//                     alignment: alignment.value,
//                     child: TriangleIndicator(),
//                   ),
//                 ],
//                 items: [
//                   for (var it in Constants.fortuneValues)
//                     FortuneItem(child: Text(it), onTap: () => print(it))
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class DailyCountdown extends StatelessWidget {
//   final StreamController<num> countdownStreamController;
//   const DailyCountdown({
//     super.key,
//     required this.countdownStreamController,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text('Closing in: ', style: TextStyle(fontSize: 18)),
//         StreamBuilder<num>(
//           stream: countdownStreamController.stream,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               num secondsRemaining = snapshot.data!;
//               num hours = secondsRemaining ~/ 3600;
//               num minutes = (secondsRemaining % 3600) ~/ 60;
//               num seconds = secondsRemaining % 60;

//               return Text(
//                 //'$hours:${twoDigits(minutes)}:${twoDigits(seconds)}',
//                 "",
//                 style: TextStyle(fontSize: 18),
//               );
//             } else {
//               return Container(); // Placeholder widget
//             }
//           },
//         ),
//       ],
//     );
//   }
// }

// class AppLayout extends StatelessWidget {
//   final Widget child;

//   const AppLayout({
//     Key? key,
//     required this.child,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       appBar: AppBar(
//         title: Text('Daily Spin'),
//       ),
//       body: child,
//     );
//   }
// }

// class Constants {
//   static List<String> get fortuneValues => const <String>[
//         '\$0',
//         '\$50',
//         '\$10',
//         '\$20',
//         '\$100',
//         '\$5',
//         '\$200',
//         '\$70',
//       ];
// }

// int roll(int itemCount) {
//   return Random().nextInt(itemCount);
// }

// typedef IntCallback = void Function(int);

// class RollButton extends StatelessWidget {
//   final VoidCallback? onPressed;

//   const RollButton({
//     Key? key,
//     this.onPressed,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       child: Text('Roll'),
//       onPressed: onPressed,
//     );
//   }

//   String twoDigits(num n) {
//     return n >= 10 ? "$n" : "0$n";
//   }
// }

// class RollButtonWithPreview extends StatelessWidget {
//   final int selected;
//   final List<String> items;
//   final VoidCallback? onPressed;

//   const RollButtonWithPreview({
//     Key? key,
//     required this.selected,
//     required this.items,
//     this.onPressed,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       spacing: 8,
//       crossAxisAlignment: WrapCrossAlignment.center,
//       direction: Axis.vertical,
//       children: [
//         RollButton(onPressed: onPressed),
//         Text('Rolled Value: ${items[selected]}'),
//       ],
//     );
//   }
// }

// // ======================================================================= //
// typedef ThemeModeBuilder = Widget Function(BuildContext, ThemeMode);

// abstract class ThemeModeProvider {
//   ThemeMode get themeMode;

//   void changeThemeMode(ThemeMode mode);

//   static ThemeModeProvider of(BuildContext context) {
//     final state = context.findAncestorStateOfType<_ThemeModeScopeState>();
//     if (state == null) {
//       throw Error();
//     }
//     return state;
//   }
// }

// class ThemeModeScope extends StatefulWidget {
//   final ThemeModeBuilder builder;

//   const ThemeModeScope({required this.builder});

//   @override
//   _ThemeModeScopeState createState() => _ThemeModeScopeState();
// }

// class _ThemeModeScopeState extends State<ThemeModeScope>
//     implements ThemeModeProvider {
//   ThemeMode _mode = ThemeMode.system;

//   ThemeMode get themeMode => _mode;

//   void changeThemeMode(ThemeMode mode) {
//     setState(() {
//       _mode = mode;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Builder(
//       builder: (context) => widget.builder(context, _mode),
//     );
//   }
// }

// class KevlatusColors {
//   static const MaterialColor blue =
//       MaterialColor(_bluePrimaryValue, <int, Color>{
//     50: Color(0xFFE7F0FC),
//     100: Color(0xFFC3DBF8),
//     200: Color(0xFF9BC3F4),
//     300: Color(0xFF73AAF0),
//     400: Color(0xFF5598EC),
//     500: Color(_bluePrimaryValue),
//     600: Color(0xFF317EE6),
//     700: Color(0xFF2A73E3),
//     800: Color(0xFF2369DF),
//     900: Color(0xFF1656D9),
//   });
//   static const int _bluePrimaryValue = 0xFF3786E9;

//   static const MaterialColor blueAccent =
//       MaterialColor(_blueAccentValue, <int, Color>{
//     100: Color(0xFFFFFFFF),
//     200: Color(_blueAccentValue),
//     400: Color(0xFFA4BFFF),
//     700: Color(0xFF8BADFF),
//   });
//   static const int _blueAccentValue = 0xFFD7E3FF;

//   static const MaterialColor gold =
//       MaterialColor(_goldPrimaryValue, <int, Color>{
//     50: Color(0xFFFCF3E7),
//     100: Color(0xFFF8E2C4),
//     200: Color(0xFFF4CE9D),
//     300: Color(0xFFF0BA75),
//     400: Color(0xFFECAC58),
//     500: Color(_goldPrimaryValue),
//     600: Color(0xFFE69534),
//     700: Color(0xFFE38B2C),
//     800: Color(0xFFDF8125),
//     900: Color(0xFFD96F18),
//   });
//   static const int _goldPrimaryValue = 0xFFE99D3A;

//   static const MaterialColor goldAccent =
//       MaterialColor(_goldAccentValue, <int, Color>{
//     100: Color(0xFFFFFFFF),
//     200: Color(_goldAccentValue),
//     400: Color(0xFFFFCBA6),
//     700: Color(0xFFFFBC8C),
//   });
//   static const int _goldAccentValue = 0xFFFFE9D9;

//   static const MaterialColor blueDark =
//       MaterialColor(_blueDarkPrimaryValue, <int, Color>{
//     50: Color(0xFFF3F8FE),
//     100: Color(0xFFE1EDFC),
//     200: Color(0xFFCDE1FA),
//     300: Color(0xFFB9D5F7),
//     400: Color(0xFFAACCF6),
//     500: Color(_blueDarkPrimaryValue),
//     600: Color(0xFF93BDF3),
//     700: Color(0xFF89B5F1),
//     800: Color(0xFF7FAEEF),
//     900: Color(0xFF6DA1EC),
//   });
//   static const int _blueDarkPrimaryValue = 0xFF9BC3F4;

//   static const MaterialColor blueDarkAccent =
//       MaterialColor(_blueDarkAccentValue, <int, Color>{
//     100: Color(0xFFFFFFFF),
//     200: Color(_blueDarkAccentValue),
//     400: Color(0xFFFCFDFF),
//     700: Color(0xFFE3EEFF),
//   });
//   static const int _blueDarkAccentValue = 0xFFFFFFFF;
// }

// final ThemeData lightTheme = ThemeData.from(
//   useMaterial3: true,
//   colorScheme: ColorScheme.fromSwatch(
//     primarySwatch: KevlatusColors.blue,
//     accentColor: KevlatusColors.goldAccent,
//     backgroundColor: Color(0xFFFAFAFA),
//   ),
// );

// final ThemeData darkTheme = ThemeData.from(
//   useMaterial3: true,
//   colorScheme: ColorScheme.fromSwatch(
//     primarySwatch: KevlatusColors.blueDark,
//     accentColor: KevlatusColors.goldAccent,
//     backgroundColor: Color(0xFF555555),
//     brightness: Brightness.dark,
//   ),
// );
