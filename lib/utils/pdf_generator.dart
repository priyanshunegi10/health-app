import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class PdfGenerator {
  
  static Future<void> generateHealthReport({
    required String name,
    required String age,
    required String weight,
    required String bmi,
    required String water,
    required String calories,
  }) async {
    final pdf = pw.Document();

    // PDF ka UI Design (Professional Medical Report jaisa)
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Center(
                child: pw.Text("Smart Health Advisory", 
                  style: pw.TextStyle(fontSize: 28, fontWeight: pw.FontWeight.bold, color: PdfColors.teal800)),
              ),
              pw.Center(
                child: pw.Text("Official Medical & Lifestyle Report", 
                  style: pw.TextStyle(fontSize: 16, color: PdfColors.grey700)),
              ),
              pw.SizedBox(height: 30),
              pw.Divider(thickness: 2),
              pw.SizedBox(height: 20),

              // Patient Details
              pw.Text("Patient Details", style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Text("Name: $name", style: pw.TextStyle(fontSize: 16)),
              pw.Text("Age: $age Years", style: pw.TextStyle(fontSize: 16)),
              pw.Text("Weight: $weight kg", style: pw.TextStyle(fontSize: 16)),
              
              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.SizedBox(height: 20),

              // Health Metrics
              pw.Text("Target Health Metrics", style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 15),
              
              _buildMetricRow("Body Mass Index (BMI):", bmi),
              _buildMetricRow("Daily Water Requirement:", "$water Liters"),
              _buildMetricRow("Daily Caloric Intake:", "$calories kcal"),

              pw.Spacer(), 
              pw.Divider(),
              pw.Center(
                child: pw.Text("Generated automatically by Health Care App", 
                  style: pw.TextStyle(fontSize: 12, color: PdfColors.grey)),
              )
            ],
          );
        },
      ),
    );

    try {
      // Phone ke storage ka path nikalna
      final output = await getApplicationDocumentsDirectory();
      final filePath = "${output.path}/Health_Report_$name.pdf";
      final file = File(filePath);

      // PDF save karna
      await file.writeAsBytes(await pdf.save());

      // PDF open karke user ko dikhana
      await OpenFile.open(filePath);
      final result = await OpenFile.open(filePath);

      print("🎯 PDF Path: $filePath");
      print("🎯 OpenFile Result: ${result.message}");
      
    } catch (e) {
      print("PDF Generation Error: $e");
    }
  }

  // Row design karne ka helper method
  static pw.Widget _buildMetricRow(String title, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(title, style: pw.TextStyle(fontSize: 16)),
          pw.Text(value, style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
        ],
      ),
    );
  }
}