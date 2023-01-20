## Preview

https://user-images.githubusercontent.com/88077166/200897923-49798844-7d32-4b00-a535-bdf43c5438a6.mp4

## Sample
```dart
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
        title: const Text('Progress Indicator'),
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MultiSliceProgressIndicator(
              radius: 90,
              status: status,
              failColors: failColors,
              inActiveColors: inActiveColors,
              successColors: succeedColors,
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
```



