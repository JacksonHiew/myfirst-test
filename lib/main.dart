import 'package:flutter/material.dart';
import 'package:map_exam/common/router/router.dart';
import 'package:map_exam/global.dart';

void main() => Global.init().then(
      (e) => runApp(
        const App(),
      ),
    );

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    Global.appRouter = AppRouter();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'myFirst',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: Global.appRouter!.config(),
    );
  }
}
