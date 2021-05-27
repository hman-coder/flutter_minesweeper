import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/repository/sqlite_accessor.dart';

/// Testing sqflite package is not available using regualr flutter_test.
/// A non-test main method is used instead to run the test.
///
/// tests:
/// sqlite_accessor,
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(SqfliteTest());
}

class SqfliteTest extends StatefulWidget {
  @override
  _SqfliteTestState createState() => _SqfliteTestState();
}

class _SqfliteTestState extends State<SqfliteTest> {
  // Represnt the test messages to be dispalyed
  List<String> messages = [];

  void addMessage(String message) {
    setState(() => messages.add(message));
  }

  void clearMessages() {
    setState(() => messages.clear());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Sqlite Repositories Test")),
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: TestPersistentHeaderDelegate(runTest),
              pinned: true,
            ),
          ]..addAll(
              messages.map(
                (e) => Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(e),
                ),
              ),
            ),
        ));
  }

  void runTest(String? testName) {
    switch (testName) {
      case "sqlite_accessor":
        runAccessorTest();
        break;
    }
  }

  void runAccessorTest() async {
    clearMessages();
    addMessage("Starting SqliteAccessor test");
    var accessor = await SqliteAccessor.accessor;
    addMessage("Fetched accessor singleton");
    var rows = await accessor.fetch("minesweeper_theme");
    addMessage(
        "Fetched these rows from minesweeper_theme table: ${rows.toString()}");
  }
}

class TestPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Function(String?) runTest;

  TestPersistentHeaderDelegate(this.runTest);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text("Select repo"),
          ),
          Expanded(
            child: DropdownButton<String>(
              onChanged: runTest,
              items: _dropdownMenuItems,
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {},
              child: Text("Run"),
            ),
          )
        ],
      ),
    );
  }

  get _dropdownMenuItems => [
        DropdownMenuItem<String>(
          value: "sqlite_accessor",
          child: Text("Sqlite accessor test"),
        ),
      ];

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 59;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
