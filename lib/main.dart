
import 'package:currency_btc/app_bloc_observer.dart';
import 'package:currency_btc/presentation/bloc/current_price_bloc.dart';
import 'package:currency_btc/presentation/page/current_price_page.dart';
import 'package:currency_btc/presentation/page/pin_code_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection.dart' as di;

void main() {
  di.init();
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<CurrentPriceBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a blue toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
        ),
        home: const HomePage(),
        // CurrentPricePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CurrentPricePage()),
                );
              },
              child: const Text(
                'CurrentPrice Page',
                style: TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PinCodePage()),
                );
              },
              child: const Text(
                'PinCode Page',
                style: TextStyle(fontSize: 20),
              ),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const ReorderableListViewPage()),
            //     );
            //
            //
            //     // Navigator.of(context).pushNamed('/preview');
            //   },
            //   child: const Text(
            //     'ReorderableListView',
            //     style: TextStyle(fontSize: 20),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
