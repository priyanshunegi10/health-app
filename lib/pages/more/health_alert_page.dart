import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HealthAlertsPage extends StatefulWidget {
  const HealthAlertsPage({super.key});

  @override
  State<HealthAlertsPage> createState() => _HealthAlertsPageState();
}

class _HealthAlertsPageState extends State<HealthAlertsPage> {
  List<dynamic> healthNews = [];
  bool isLoading = true;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    fetchHealthNews();
  }

  
  Future<void> fetchHealthNews() async {
    
    const String apiKey = "3be0828ed1474d76a57d31a96db261c7"; 
    
    
    const String url = "https://newsapi.org/v2/everything?q=health+medical&language=en&sortBy=publishedAt&apiKey=$apiKey";

    try {
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
         
          healthNews = data['articles'].where((article) => article['title'] != null && article['description'] != null).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = "Server error. Could not fetch news.";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "No internet connection. Please check your Wi-Fi/Data.";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text("Live Health Alerts", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    
    if (isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Color(0xFF2E8B90)),
            SizedBox(height: 15),
            Text("Fetching latest health updates...", style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    
    if (errorMessage.isNotEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off_rounded, size: 60, color: Colors.redAccent),
              const SizedBox(height: 15),
              Text(errorMessage, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isLoading = true;
                    errorMessage = "";
                  });
                  fetchHealthNews();
                },
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2E8B90)),
                child: const Text("Retry", style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      );
    }

    
    if (healthNews.isEmpty) {
      return const Center(child: Text("No health news available right now."));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: healthNews.length,
      itemBuilder: (context, index) {
        var news = healthNews[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(15),
            leading: const Icon(Icons.campaign_outlined, color: Colors.orange, size: 30),
            title: Text(
              news['title'],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                news['description'] ?? "No description available.",
                style: TextStyle(color: Colors.black87.withOpacity(0.7), fontSize: 13),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        );
      },
    );
  }
}