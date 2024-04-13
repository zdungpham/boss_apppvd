import 'package:flutter/material.dart';
import 'dart:async';
import 'package:vibration/vibration.dart';

class VerusHillaScreen extends StatefulWidget {
  const VerusHillaScreen({super.key});
  @override
  State<VerusHillaScreen> createState(){
    return  _VerusHillaScreenState();
  }
}

class _VerusHillaScreenState extends State<VerusHillaScreen> {
  int choosePhase = 0;
  late Timer timer;
  int countDown = 150;
  bool timerStarted = false;

  String formatDuration(int duration) {
    int minutes = duration ~/ 60;
    int seconds = duration % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

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
        if (countDown == 0) {
          timer.cancel();
        } else {
          setState(() {
            if (countDown > 0) {
              countDown--;
              //if (countDown1 < 5) Vibration.vibrate();
            }

          });
        }
      },
    );
  }

  void addSecond(int timer) {
    setState(() {
      if (timer == 1) {
        countDown += 1;
      }
    });
  }

  void addFiveSeconds(int timer) {
    setState(() {
      if (timer == 1) {
        countDown += 5;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> dropdownOptions = ['Phase 1', 'Phase 2', 'Phase 3', 'phase 4'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verus Hilla'),
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
                  countDown = 150;
                } else if(choosePhase == 1){
                  timer.cancel();
                  timerStarted = false;
                  countDown = 125;
                } else if(choosePhase == 2){
                  timer.cancel();
                  timerStarted = false;
                  countDown = 100;
                } else if(choosePhase == 3){
                  timer.cancel();
                  timerStarted = false;
                  countDown = 75;
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
                      '00:${formatDuration(countDown)}',
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
