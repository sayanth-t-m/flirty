import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:switcher_button/switcher_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  const MyHomePage({required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool switchValue = true;
  TextEditingController _textEditingController = TextEditingController();
  bool isInputEmpty = true;

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      setState(() {
        isInputEmpty = _textEditingController.text.isEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff432e81),
        toolbarHeight: 110,
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
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "NERD",
                    // style: txtstyle(), // You didn't provide the txtstyle function, so using the default style.
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
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "SIMP",
                    // style: txtstyle(), // You didn't provide the txtstyle function, so using the default style.
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
          Expanded(
              child: Container(
            color: Color(0xff1c1b1f),
            child: Center(child: Text("Container")),
            width: 400,
            height: 640,
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(color: Colors.cyanAccent,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurple, // Dark violet color
                          blurRadius: 10.0, // Adjust the blur radius as needed
                          offset: Offset(0, 4), // Adjust the shadow's offset
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _textEditingController,
                      onChanged: (value) {
                        setState(() {
                          isInputEmpty = value.isEmpty;
                        });
                      },
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: 'Type something...',
                        filled: true,
                        fillColor: Colors.grey[900],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 20.0,
                        ),
                      ),
                    ),
                  )

                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: isInputEmpty
                      ? null
                      : () {
                          // Handle send button press
                          // You can implement the logic to send the message here
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isInputEmpty ? Color(0xff212121) : null,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: isInputEmpty ? Color(0xff212121) : null,
                    ),
                    child: const Icon(
                      Icons.arrow_circle_up_rounded,
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
