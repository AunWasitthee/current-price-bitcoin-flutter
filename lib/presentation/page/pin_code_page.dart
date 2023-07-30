import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PinCodePage extends StatefulWidget {
  const PinCodePage({Key? key}) : super(key: key);

  @override
  State<PinCodePage> createState() => _PinCodePageState();
}

class _PinCodePageState extends State<PinCodePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Pin Code')),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1, color: Colors.teal), //<-- SEE HERE
            ),
          ),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
          ],
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            } else if (value.length < 6) {
              return 'input จะต้องมีความยาวมากกว่าหรือเท่ากับ 6 ตัวอักษร';
            } else if (checkDuplicate(value)) {
              return 'input จะต้องกันไม่ให้มีเลขซ้ำติดกันเกิน 2 ตัว';
            } else if (checkSequential(value)) {
              return 'input จะต้องกันไม่ให้มีเลขเรียงกันเกิน 2 ตัว';
            } else if (checkDuplicate2Set(value)) {
              return 'input จะต้องกันไม่ให้มีเลขชุดซ้ำ เกิน 2 ชุด';
            }
            return null;
          },
        ),
      ),
    );
  }

  bool checkDuplicate(String value) {
    for (var i = 0; i < value.length - 2; i++) {
      if (value[i] == value[i + 1] && value[i] == value[i + 2]) {
        return true;
      }
    }
    return false;
  }

  bool checkSequential(String value) {
    for (var i = 0; i < value.length - 2; i++) {
      if ((int.parse(value[i]) + 1 == (int.parse(value[i + 1]))) &&
          (int.parse(value[i]) + 2 == (int.parse(value[i + 2])))) {
        return true;
      } else if ((int.parse(value[i]) - 1 == (int.parse(value[i + 1]))) &&
          (int.parse(value[i]) - 2 == (int.parse(value[i + 2])))) {
        return true;
      }
    }
    return false;
  }

  bool checkDuplicate2Set(String value) {
    var count = 0;
    for (var i = 0; i < value.length - 1; i++) {
      if (value[i] == value[i + 1]) {
        count += 1;
      }
    }
    if (count > 2) {
      return true;
    }
    return false;
  }
}
