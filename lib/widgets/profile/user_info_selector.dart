import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserInfoSelector extends StatelessWidget {
  int selectedIndex;
  Function(int) onSelect;
  UserInfoSelector({super.key, required this.selectedIndex, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Positioned(
          bottom: 32,
          left: 96,
          right: 96,
          child: Container(
            height: 32,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.8)),
            ]),
          ),
        ),
        Positioned(
          bottom: 32,
          left: 64,
          right: 64,
          child: Container(
            height: 68,
            decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      onSelect(1);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      decoration: BoxDecoration(
                        color: selectedIndex == 1 ? const Color.fromARGB(255, 43, 99, 241) : Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [Text('اطلاعات\n شناسنامه‌ای', style: TextStyle(fontSize: 12, color: Colors.white), textAlign: TextAlign.center)],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      onSelect(2);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      decoration: BoxDecoration(
                        color: selectedIndex == 2 ? const Color.fromARGB(255, 43, 99, 241) : Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [Text('اطلاعات \n شغلی', style: TextStyle(fontSize: 12, color: Colors.white), textAlign: TextAlign.center)],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      onSelect(3);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      decoration: BoxDecoration(
                        color: selectedIndex == 3 ? const Color.fromARGB(255, 43, 99, 241) : Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [Text('اطلاعات \n تحصیلی', style: TextStyle(fontSize: 12, color: Colors.white), textAlign: TextAlign.center)],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
          ),
        )
      ],
    );
  }
}
