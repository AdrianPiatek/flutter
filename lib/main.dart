import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Student App"),
        ),
        body: const HomeView(),
      ),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String _title = 'From decimal to binary';
  int _sysChoice = 0;
  RegExp _regExp = RegExp(r'[0-9]');
  String _result = '';
  TextInputType _inputType = TextInputType.number;
  final TextEditingController _controller = TextEditingController();

  void _toggleState(int val) {
    setState(() {
      _sysChoice = val;
      _controller.clear();
      _result = '';
      FocusScope.of(context).requestFocus(FocusNode());
      switch (_sysChoice) {
        case 0:
          _title = 'From decimal to binary';
          _regExp = RegExp(r'[0-9]');
          _inputType = TextInputType.number;
          break;
        case 1:
          _title = 'From binary to decimal';
          _regExp = RegExp(r'0|1');
          _inputType = TextInputType.number;
          break;
        case 2:
          _title = 'From decimal to hexadecimal';
          _regExp = RegExp(r'[0-9]');
          _inputType = TextInputType.number;
          break;
        case 3:
          _title = 'From hexadecimal to decimal';
          _regExp = RegExp(r'[0-9]|[a-f]');
          _inputType = TextInputType.text;
          break;
        case 4:
          _title = 'From hexadecimal to binary';
          _regExp = RegExp(r'[0-9]|[a-f]');
          _inputType = TextInputType.text;
          break;
        case 5:
          _title = 'From binary to hexadecimal';
          _regExp = RegExp(r'0|1');
          _inputType = TextInputType.number;
      }
    });
  }

  void _convert() {
    setState(() {
      String val = _controller.value.text;
      if (val.isEmpty) return;
      switch (_sysChoice) {
        case 0:
          _result = int.parse(val).toRadixString(2);
          break;
        case 1:
          _result = int.parse(val, radix: 2).toString();
          break;
        case 2:
          _result = int.parse(val).toRadixString(16);
          break;
        case 3:
          _result = int.parse(val, radix: 16).toString();
          break;
        case 4:
          _result = int.parse(val, radix: 16).toRadixString(2);
          break;
        case 5:
          _result = int.parse(val, radix: 2).toRadixString(16);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            _title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 30),
              child: TextField(
                keyboardType: _inputType,
                controller: _controller,
                inputFormatters: [FilteringTextInputFormatter.allow(_regExp)],
                onSubmitted: (v) {
                  _convert();
                },
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  _toggleState(0);
                },
                child: const Text('dec -> bi'),
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 16)),
              ),
              TextButton(
                onPressed: () {
                  _toggleState(1);
                },
                child: const Text('bi -> dec'),
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 16)),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  _toggleState(2);
                },
                child: const Text('dec -> hex'),
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 16)),
              ),
              TextButton(
                onPressed: () {
                  _toggleState(3);
                },
                child: const Text('hex -> dec'),
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 16)),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  _toggleState(4);
                },
                child: const Text('hex -> bi'),
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 16)),
              ),
              TextButton(
                onPressed: () {
                  _toggleState(5);
                },
                child: const Text('bi -> hex'),
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 16)),
              ),
            ],
          ),
          const Spacer(),
          Text(
            _result,
            style: const TextStyle(fontSize: 20),
          ),
          const Spacer(),
          TextButton(
            onPressed: _convert,
            child: const Text('convert'),
            style: TextButton.styleFrom(
                backgroundColor: Colors.teal,
                primary: Colors.white,
                textStyle: const TextStyle(fontSize: 20)),
          )
        ],
      ),
    );
  }
}
