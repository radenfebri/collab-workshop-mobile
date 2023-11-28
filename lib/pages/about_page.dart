import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jual_buku/controllers/about_controller.dart';
import 'package:jual_buku/models/about_model.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  List<AboutModel> aboutData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAboutData();
  }

  Future<void> fetchAboutData() async {
    try {
      var about = await AboutController.fetchAboutData();
      setState(() {
        aboutData = about;
        isLoading = false;
      });
    } catch (e) {
      print('Failed to fetch about data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF177DFF),
        title: Text('About', style: GoogleFonts.poppins()),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: aboutData.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        aboutData[index].text,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
