import 'package:flutter/material.dart';
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
        title: Text('FAQ'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: faqList.length,
              itemBuilder: (context, index) {
                var faq = faqList[index];
                return ExpansionTile(
                  title: Text(
                    faq.pertanyaan,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Text(
                        faq.jawaban,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
