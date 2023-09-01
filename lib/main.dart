import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:switcher_button/switcher_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'const.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pluto',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Pluto'),
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
  String responseText = 'Hello Dear';
  bool isLoading = false; // New state variable for loading indicator
  final String apiKey = 'AIzaSyBCI9jtEMyw83QU-0ae-LMlAzE-WYi9T3I'; // Replace with your actual API key
  final String apiUrl =
      'https://generativelanguage.googleapis.com/v1beta2/models/text-bison-001:generateText';

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      setState(() {
        isInputEmpty = _textEditingController.text.isEmpty;
      });
    });
  }

  Future<void> sendRequestAndReceiveResponse() async {
    final String inputText = _textEditingController.text;
    String promptText;

    if (switchValue) {
      // When switch is enabled
      promptText =
          "Give a single flirty reply that sounds like a romantic and sexual pickup line for the following text message i got from a girl: '$inputText'";
    } else {
      // When switch is disabled
      promptText =
          "Give a reply that sounds like a highly intelligent and Godly being,for the following text message: '$inputText'";
    }

    final Map<String, dynamic> requestBody = {
      "prompt": {"text": promptText},
      "temperature": 0.8,
      "candidateCount": 2
    };

    // Set isLoading to true to show the loading indicator
    setState(() {
      isLoading = true;
    });

    final response = await http.post(
      Uri.parse('$apiUrl?key=$apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      List<dynamic> candidates = responseData['candidates'];

      if (candidates.isNotEmpty) {
        String completionText = candidates[0]['output'];
        setState(() {
          responseText = completionText;
          _textEditingController.clear();
          isInputEmpty = true;
        });
      }
    } else {
      setState(() {
        responseText = 'Failed to fetch completion: ${response.statusCode}';
      });
    }

    // Set isLoading to false to hide the loading indicator
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define the AppBar color based on switchValue
    Color appBarColor = switchValue ? const Color(0xff432e81) : Colors.green;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor, // Use the defined color
        toolbarHeight: 110,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                fontFamily: GoogleFonts.playfairDisplay().fontFamily,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text("G MAN"),
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
                  child: Text("CUPID"),
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
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                color: Color(0xff1c1b1f),
                child: Center(
                  child: isLoading
                      ? CircularProgressIndicator() // Show loading indicator
                      : SingleChildScrollView(
                        child: Text(responseText,
                            style:
                                txtstyle()),
                      ), // Display the response or loading indicator
                ),
                width: 400,
                height: 640,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.cyanAccent,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff432e80),
                          blurRadius: 5.0,
                          offset: Offset(0, 0),
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
                  ),
                ),
                const SizedBox(width: 8),
                if (!isInputEmpty)
                  ElevatedButton(
                    onPressed: () {
                      sendRequestAndReceiveResponse();
                    },
                    style: ElevatedButton.styleFrom(
                      shadowColor: Color(0xff432e80),
                      backgroundColor: Colors.transparent,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xff1c1b1f),
                      ),
                      child: const Icon(
                        Icons.arrow_circle_up_rounded,
                        size: 45,
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
