import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NotaTalk',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    bool isExtended = false;

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = TalkPage();
        break;
      case 1:
        page = Placeholder();
      case 2:
        page = Placeholder();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('NotaTalk'),
        ),
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                backgroundColor: Color.fromARGB(255, 26, 26, 40),
                unselectedIconTheme: IconThemeData(color: Colors.grey),
                labelType: NavigationRailLabelType.none,
                extended: isExtended /*constraints.maxWidth >= 600*/,
                destinations: [
                  NavigationRailDestination(
                      icon: Icon(
                        Icons.home,
                      ),
                      label: Text(
                        'Home',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                      )),
                  NavigationRailDestination(
                      icon: Icon(Icons.explore),
                      label: Text(
                        'Explorer',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                      )),
                  NavigationRailDestination(
                      icon: Icon(Icons.settings),
                      label: Text(
                        'Settings',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ))
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
                child: Container(
              color: Theme.of(context).colorScheme.onBackground,
              child: page,
            ))
          ],
        ),
      );
    });
  }
}

class TalkPage extends StatelessWidget {
  TalkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background.withOpacity(0.3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  floating: true,
                  expandedHeight: 70,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          ' ',
                        ),
                        Text(
                          '人物(null)',
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return ListTile(
                        title: Text('Item $index'),
                      );
                    },
                    childCount: 20,
                  ),
                ),
              ],
            ),
          ),
          Flexible(flex: 1, child: Placeholder())
        ],
      ),
    );
  }
}
