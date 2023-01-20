import 'package:flutter/material.dart';
import 'package:multi_slice_progress_indicator/multi_slice_progress_indicator/multi_slice_progress_indicator.dart';
import 'package:multi_slice_progress_indicator/multi_slice_progress_indicator/progress_indicator_status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProgressIndicatorStatus status = ProgressIndicatorStatus.cancel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('progress indicator'),
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MultiSliceProgressIndicator(
              radius: 90,
              status: status,
            ),
            const SizedBox(height: 20),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 20,
              children: [
                ElevatedButton(
                  onPressed: () {
                    status = ProgressIndicatorStatus.start;
                    setState(() {});
                  },
                  child: const Text('start'),
                ),
                ElevatedButton(
                  onPressed: () {
                    status = ProgressIndicatorStatus.reverse;
                    setState(() {});
                  },
                  child: const Text('reverse'),
                ),
                ElevatedButton(
                  onPressed: () {
                    status = ProgressIndicatorStatus.cancel;
                    setState(() {});
                  },
                  child: const Text('cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    status = ProgressIndicatorStatus.fail;
                    setState(() {});
                  },
                  child: const Text('fail'),
                ),
                ElevatedButton(
                  onPressed: () {
                    status = ProgressIndicatorStatus.succeed;
                    setState(() {});
                  },
                  child: const Text('succeed'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
