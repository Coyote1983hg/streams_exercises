import 'package:flutter/material.dart';
import 'package:streams_exercises/features/time/time_repository.dart';
import 'package:intl/intl.dart'; // Import this for date formatting

class TimeScreen extends StatelessWidget {
  const TimeScreen({
    super.key,
    required this.timeRepository,
  });

  final TimeRepository timeRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Screen'),
      ),
      body: Center(
        child: StreamBuilder<DateTime>(
          stream: timeRepository.dateTimeStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              // Format the time as desired
              String formattedTime = DateFormat('HH:mm:ss').format(snapshot.data!);
              return Text(
                formattedTime,
                style: Theme.of(context).textTheme.displayMedium,
              );
            } else {
              return const Text('No data available');
            }
          },
        ),
      ),
    );
  }
}
