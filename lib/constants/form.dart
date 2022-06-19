import 'package:flutter/material.dart';

class TeksFormulir extends StatelessWidget {
  const TeksFormulir(
      {Key? key,
      required this.kontroler,
      required this.teks,
      required this.teksValidator,
      this.aksiInput,
      this.sensorinputan = false})
      : super(key: key);
  final TextEditingController kontroler;
  final String teks;
  final bool sensorinputan;
  final String teksValidator;
  final TextInputAction? aksiInput;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: kontroler,
        obscureText: sensorinputan,
        textInputAction: aksiInput,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return teksValidator;
          }
          return null;
        },
        decoration: InputDecoration(
            border: const OutlineInputBorder(), labelText: teks));
  }
}

class TeksFormulirAkun extends StatelessWidget {
  const TeksFormulirAkun(
      {Key? key,
      required this.kontroler,
      required this.teks,
      required this.teksValidatorKosong,
      required this.teksValidatorMinimal,
      this.aksiInput,
      this.sensorinputan = false})
      : super(key: key);
  final TextEditingController kontroler;
  final String teks;
  final bool sensorinputan;
  final String teksValidatorKosong;
  final String teksValidatorMinimal;
  final TextInputAction? aksiInput;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: kontroler,
        obscureText: sensorinputan,
        textInputAction: aksiInput,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return teksValidatorKosong;
          } else if (value.length < 8) {
            return teksValidatorMinimal;
          }
          return null;
        },
        decoration: InputDecoration(
            border: const OutlineInputBorder(), labelText: teks));
  }
}
