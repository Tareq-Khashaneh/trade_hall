import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class SessionCard extends StatelessWidget {
  SessionCard({super.key, required this.sessionInfo, required this.onTap});
  final String sessionInfo;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 5, right: 4),
        height: 100,
        width: double.infinity,
        child: Card(
          elevation: 4,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),

          margin: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 18,
              ),
              const Icon(Icons.timelapse_rounded),
              const SizedBox(
                width: 7,
              ),
              Text(sessionInfo, style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 20)),
              const SizedBox(
                width: 20,
              ),
              const Icon(Icons.keyboard_arrow_left_rounded,size: 30,color: Colors.grey,)
            ],
          ),
        ),
      ),
    );
  }
}
