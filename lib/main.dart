import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tooltip Issue',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final tooltipKey = GlobalKey<TooltipState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tooltip Issue')),
      body: Align(
        alignment: Alignment.topCenter,
        child: Tooltip(
          key: tooltipKey,
          textAlign: TextAlign.left,
          richMessage: const TextSpan(
            children: [
              TextSpan(
                text: 'Warning 1: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                  text: 'Lorem ipsum dolor sit amet, \n'
                      'consectetur adipiscing elit.'),
              TextSpan(text: '\n\n'),
              TextSpan(
                text: 'Warning 2: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: 'Duis lacus mauris,\nefficitur non blandit a'),
            ],
          ),
          triggerMode: TooltipTriggerMode.tap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Your device has 2 warnings.'),
              Builder(
                builder: (context) => IconButton(
                  onPressed: () async {
                    tooltipKey.currentState?.ensureTooltipVisible();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Tapped button. ensureTooltipVisible() called'),
                        showCloseIcon: true,
                      ),
                    );
                  },
                  icon: const Icon(Icons.warning),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
