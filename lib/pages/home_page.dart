import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  const HomePage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 80)),
            const Text('Bluetooth mouse'),
            const Padding(padding: EdgeInsets.only(top: 40)),
            SizedBox(
              width: 200,
              child: TextField(
                // only accept numbers
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  hintText: 'Nhập giá...',
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 40)),
            ElevatedButton(
              onPressed: () {
                
              }, child: const Text('Check'),
            )
          ],
        ),
      ),
    );
  }
}