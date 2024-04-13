import 'package:flutter/material.dart';
import 'dart:async';
import 'package:vibration/vibration.dart';

class BlackMageScreen extends StatefulWidget {
  const BlackMageScreen({super.key});
  
  @override
  State<BlackMageScreen> createState(){
    return _BlackMageScreenState();
    }
}

class _BlackMageScreenState extends State<BlackMageScreen> {

  String formatDuration(int duration) {
    int minutes = duration ~/ 60;
    int seconds = duration % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  int choosePhase = 0;
  late Timer timer;
  int countDown1 = 30;
  int countDown2 = 40;
  bool timerStarted = false;

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void startTimers() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (countDown1 == 0 && countDown2 == 0) {
          timer.cancel();
        } else {
          setState(() {
            if (countDown1 > 0) {
              countDown1--;
              //if (countDown1 < 5) Vibration.vibrate();
            }
            if (countDown2 > 0) {
              countDown2--;
             // if (countDown2 < 5) Vibration.vibrate();
            }
          });
        }
      },
    );
  }

  void addSecond(int timer) {
    setState(() {
      if (timer == 1) {
        countDown1 += 1;
      } else if (timer == 2) {
        countDown2 += 1;
      }
    });
  }

  void addFiveSeconds(int timer) {
    setState(() {
      if (timer == 1) {
        countDown1 += 5;
      } else if (timer == 2) {
        countDown2 += 5;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> dropdownOptions = ['Phase 1', 'Phase 2', 'Phase 3'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Black Mage'),
        centerTitle: true,
          backgroundColor: Colors.brown,
      ),
      body: Center(
        child: Column(
          children: [
            DropdownButton<int>(
              value: choosePhase,
              items: dropdownOptions.asMap().entries.map((entry) {
                return DropdownMenuItem<int>(
                  value: entry.key,
                  child: Text(entry.value),
                );
              }).toList(),
              onChanged: (index) {
                setState(() {
                  choosePhase = index!;
                });
                if (choosePhase == 0) {
                  timer.cancel();
                  timerStarted = false;
                  countDown1 = 30;
                  countDown2 = 40;
                } else if(choosePhase == 1){
                  timer.cancel();
                  timerStarted = false;
                  countDown1 = 70;
                  countDown2 = 40;
                } else if(choosePhase == 2){
                  timer.cancel();
                  timerStarted = false;
                  countDown1 = 30;
                  countDown2 = 20;
                }
              },
            ),
            const SizedBox(height: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text(
                      'Timer 1:',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '00:${formatDuration(countDown1)}',
                      style: const TextStyle(fontSize: 40, color: Colors.red),
                    ),
                    ElevatedButton(
                      onPressed: () => addSecond(1),
                      child: const Text('+1s'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => addFiveSeconds(1),
                      child: const Text('+5s'),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  children: [
                    const Text(
                      'Timer 2:',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '00:${formatDuration(countDown2)}',
                      style: const TextStyle(fontSize: 40, color: Colors.red),
                    ),
                    ElevatedButton(
                      onPressed: () => addSecond(2),
                      child: const Text('+1s'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => addFiveSeconds(2),
                      child: const Text('+5s'),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    if (!timerStarted) {
                      startTimers();
                      setState(() {
                        timerStarted = true;
                      });
                    }
                  },
                  child: const Text('Start Timer'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
