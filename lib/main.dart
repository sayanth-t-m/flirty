import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nerd_gpt/const.dart';
import 'package:switcher_button/switcher_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nerd GPT',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Nerd GPT'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool switchValue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff432e81),
        toolbarHeight: 110, // Adjust the toolbar height here
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  fontFamily: GoogleFonts.playfairDisplay().fontFamily),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "NERD",
                    style: txtstyle(),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12.0, right: 12, top: 12),
                  child: SwitcherButton(
                    value: switchValue,
                    onChange: (value) {
                      setState(() {
                        switchValue = value;
                      });
                      print(value);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "SIMP",
                    style: txtstyle(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Type something...',
                        filled: true,
                        fillColor: Colors.grey[800],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8), // Add some spacing between TextField and Send button
                  ElevatedButton(
                    onPressed: () {
                      // Handle send button press
                      // You can implement the logic to send the message here
                    },
                    child: Icon(Icons.arrow_circle_up_rounded,size: 45,),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

    );
  }
}
