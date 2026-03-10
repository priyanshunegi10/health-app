import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class MyReportsPage extends StatefulWidget {
  const MyReportsPage({super.key});

  @override
  State<MyReportsPage> createState() => _MyReportsPageState();
}

class _MyReportsPageState extends State<MyReportsPage> {
  bool isUploading = false;

  Future<void> uploadReportLocally() async {
    setState(() {
      isUploading = true;
    });

    try {
      // 1. User se PDF select karwana
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        File selectedFile = File(result.files.single.path!);
        String fileName = result.files.single.name;

        // 2. Phone ki secure directory nikalna
        final directory = await getApplicationDocumentsDirectory();
        final String localPath = '${directory.path}/$fileName';

        // 3. File ko app ki local storage me copy karna
        final File savedFile = await selectedFile.copy(localPath);

        // 4. Firestore me sirf Path aur naam save karna
        final String? uid = FirebaseAuth.instance.currentUser?.uid;
        if (uid != null) {
          await FirebaseFirestore.instance.collection("UserReports").add({
            "userId": uid,
            "reportName": fileName,
            "localFilePath": savedFile.path,
            "uploadedAt": FieldValue.serverTimestamp(),
          });

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Report Saved Successfully!")),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Upload Failed: $e")));
      }
    }

    setState(() {
      isUploading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String? uid = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          "My Medical Reports",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: uid == null
          ? const Center(child: Text("User not logged in"))
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("UserReports")
                  .where("userId", isEqualTo: uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      "No reports uploaded yet.\nClick '+' to add your first report.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  );
                }

                var reports = snapshot.data!.docs;

                return ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: reports.length,
                  itemBuilder: (context, index) {
                    var reportData =
                        reports[index].data() as Map<String, dynamic>;
                    String reportName =
                        reportData['reportName'] ?? 'Unknown Report';
                    String localPath = reportData['localFilePath'] ?? '';

                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        leading: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.picture_as_pdf,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
                        title: Text(
                          reportName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: const Text(
                          "Tap to view report",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        trailing: const Icon(
                          Icons.remove_red_eye,
                          color: Color(0xFF2E8B90),
                        ),
                        onTap: () async {
                          // PDF OPEN KARNE KA LOGIC
                          if (localPath.isNotEmpty) {
                            final result = await OpenFile.open(localPath);
                            if (result.type != ResultType.done) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Error opening file: ${result.message}",
                                  ),
                                ),
                              );
                            }
                          }
                        },
                      ),
                    );
                  },
                );
              },
            ),
      // UPLOAD BUTTON (Floating)
      floatingActionButton: FloatingActionButton.extended(
        onPressed: isUploading ? null : uploadReportLocally,
        backgroundColor: const Color(0xFF2E8B90),
        icon: isUploading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Icon(Icons.upload_file, color: Colors.white),
        label: Text(
          isUploading ? "Processing..." : "Upload Report",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
