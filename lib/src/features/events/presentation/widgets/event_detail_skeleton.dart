import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mesran_app/src/config/styles/themes/colors/neutral.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EventDetailSkeleton extends StatelessWidget {
  const EventDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Skeletonizer(
          child: Container(
            width: 150,
            height: 20,
            color: Colors.grey[300],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Skeletonizer(
              child: Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey[300],
              ),
            ),
            Gap(16),
            Skeletonizer(
              child: Container(
                width: 200,
                height: 20,
                color: Colors.grey[300],
              ),
            ),
            Gap(8),
            Skeletonizer(
              child: Container(
                width: double.infinity,
                height: 20,
                color: Colors.grey[300],
              ),
            ),
            Gap(8),
            Skeletonizer(
              child: Container(
                width: double.infinity,
                height: 20,
                color: Colors.grey[300],
              ),
            ),
            Gap(8),
            Skeletonizer(
              child: Container(
                width: double.infinity,
                height: 20,
                color: Colors.grey[300],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: white,
    );
  }
}
