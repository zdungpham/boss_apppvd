import 'package:flutter/material.dart';
import 'dart:async';
import 'package:vibration/vibration.dart';

class KalosScreen extends StatefulWidget {
  const KalosScreen({super.key});
  
  @override
  State<KalosScreen> createState(){
    return _KalosScreenState();
    }
}

class _KalosScreenState extends State<KalosScreen> {

  String formatDuration(int duration) {
    int minutes = duration ~/ 60;
    int seconds = duration % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  int choosePhase = 0;
  late Timer timer;
  int countDown1 = 30;
  int countDown2 = 30;
  int countDown3 = 150;
  int countDown4 = 0;
  bool timerStarted = false;

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void resetButton(int timer){
    setState(() {
      if (timer == 1) {
        countDown1 = 30;
      } else if (timer == 2) {
        countDown2 = 30;
      } else if (timer == 3) {
        countDown3 = 150;
      } else if (timer == 4) {
        countDown4 = 50;
      }
    });
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
            if (countDown3 > 0) {
              countDown3--;
             // if (countDown2 < 5) Vibration.vibrate();
            }
            if (countDown4 > 0) {
              countDown4--;
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
      } else if (timer == 3) {
        countDown3 += 1;
      } else if (timer == 4) {
        countDown4 += 1;
      }
    });
  }

  void addFiveSeconds(int timer) {
    setState(() {
      if (timer == 1) {
        countDown1 += 5;
      } else if (timer == 2) {
        countDown2 += 5;
      } else if (timer == 3) {
        countDown3 += 5;
      } else if (timer == 4) {
        countDown4 += 5;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> dropdownOptions = ['Phase 1', 'Phase 2'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalos'),
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
                  countDown2 = 30;
                  countDown3 = 150;
                  countDown4 = 0;
                } else if(choosePhase == 1){
                  timer.cancel();
                  timerStarted = false;
                  countDown1 = 30;
                  countDown2 = 30;
                  countDown3 = 150;
                  countDown4 = 50;
                }
              },
            ),
            const SizedBox(height: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Left totem:',
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
                        ElevatedButton(
                          onPressed: () => resetButton(1),
                          child: const Text('Reset'),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      children: [
                        const Text(
                          'Right totem:',
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
                        ElevatedButton(
                          onPressed: () => resetButton(2),
                          child: const Text('Reset'),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Rocket:',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          '00:${formatDuration(countDown3)}',
                          style: const TextStyle(fontSize: 40, color: Colors.red),
                        ),
                        ElevatedButton(
                          onPressed: () => addSecond(3),
                          child: const Text('+1s'),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () => addFiveSeconds(3),
                          child: const Text('+5s'),
                        ),
                        ElevatedButton(
                          onPressed: () => resetButton(3),
                          child: const Text('Reset'),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      children: [
                        const Text(
                          'Kamejoko:',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          '00:${formatDuration(countDown4)}',
                          style: const TextStyle(fontSize: 40, color: Colors.red),
                        ),
                        ElevatedButton(
                          onPressed: () => addSecond(4),
                          child: const Text('+1s'),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () => addFiveSeconds(4),
                          child: const Text('+5s'),
                        ),
                        ElevatedButton(
                          onPressed: () => resetButton(4),
                          child: const Text('Reset'),
                        ),
                      ],
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
