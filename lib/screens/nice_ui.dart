import 'package:flutter/material.dart';

class NiceUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Colors.orange,
                  ),
                ),
                // Expanded(
                //   child: Container(
                //     color: Colors.white,
                //   ),
                // ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: Colors.green,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[Text("TEJ"),],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.white,
                elevation: 5,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: "Enter Username"),
                    ),
                    TextFormField(),
                    TextFormField()
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
