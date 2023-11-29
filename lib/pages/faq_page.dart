import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jual_buku/controllers/faq_controller.dart';
import 'package:jual_buku/models/faq_model.dart';

class FaqPage extends StatefulWidget {
  @override
  _FaqPageState createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  List<FaqModel> faqList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFaqData();
  }

  Future<void> fetchFaqData() async {
    try {
      var faqs = await FaqController.fetchFaqData();
      setState(() {
        faqList = faqs;
        isLoading = false;
      });
    } catch (e) {
      print('Failed to fetch FAQ data: $e');
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
        title: Text('FAQ', style: GoogleFonts.poppins()),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: faqList.length,
              itemBuilder: (context, index) {
                var faq = faqList[index];
                return Card(
                  elevation: 2.0,
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: ExpansionTile(
                    title: Text(
                      faq.pertanyaan,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          faq.jawaban,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
