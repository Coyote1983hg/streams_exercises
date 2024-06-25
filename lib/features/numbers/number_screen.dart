import 'package:flutter/material.dart';
import 'package:streams_exercises/features/numbers/number_repository.dart';

class NumberScreen extends StatelessWidget {
  const NumberScreen({
    super.key,
    required this.numberRepository,
  });

  final NumberRepository numberRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Screen'),
      ),
      body: Center(
        child: StreamBuilder<int>(
          stream: numberRepository.getNumberStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return Text(
                'Number: ${snapshot.data}',
                style: Theme.of(context).textTheme.headlineMedium,
              );
            } else {
              return const Text('No data');
            }
          },
        ),
      ),
    );
  }
}
