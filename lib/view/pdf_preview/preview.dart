import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mind_bend_doc/api/gsheets_api.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:mind_bend_doc/Model/MOU_model.dart';

class PreviewScreen extends StatelessWidget {
  final MouModel mouData;

  const PreviewScreen({super.key, required this.mouData});

  // Load images for header and footer
  Future<Uint8List> _loadImage(String path) async {
    final ByteData data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }

  // Generate PDF document with header and footer images
  Future<Uint8List> _buildPdf(PdfPageFormat format) async {
    final pdf = pw.Document();

    // Load the header and footer images
    final headerImage = pw.MemoryImage(await _loadImage('assets/header.png'));
    final footerImage = pw.MemoryImage(await _loadImage('assets/footer.png'));

    pdf.addPage(
      pw.MultiPage(
        pageFormat: format,
        header: (pw.Context context) {
          return pw.Image(headerImage,
              width: format.availableWidth, height: 200);
        },
        footer: (pw.Context context) {
          return pw.Image(footerImage,
              width: format.availableWidth, height: 100);
        },
        build: (pw.Context context) => [
          pw.Padding(
            padding:
            const pw.EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            child: pw.Column(
              children: [
                // Centered Title
                pw.Align(
                  alignment: pw.Alignment.center,
                  child: pw.Text(
                    "Memorandum of Understanding",
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                      decoration: pw.TextDecoration.underline,
                    ),
                  ),
                ),
                pw.SizedBox(height: 20),

                // Left-aligned content
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text(
                    "This Memorandum of Understanding (MOU) is made on  ${mouData.date} by and between:",
                    style: pw.TextStyle(
                        fontSize: 12, fontWeight: pw.FontWeight.bold),
                    textAlign: pw.TextAlign.justify,

                  ),
                ),
                pw.SizedBox(height: 8),

                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text(
                    "1. ${mouData.orgName}",
                    style: pw.TextStyle(
                        fontSize: 12, fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Bullet(
                    text: " Address: ${mouData.orgAddress.trim()}",
                    style: pw.TextStyle(fontSize: 12),
                    textAlign: pw.TextAlign.justify,

                  ),
                ),
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Bullet(
                    text: " Contact: ${mouData.orgContact.trim()}",
                    style: pw.TextStyle(fontSize: 12),
                    textAlign: pw.TextAlign.justify,

                  ),
                ),
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Bullet(
                    text: " Phone: ${mouData.orgPhone.trim()}",
                    style: pw.TextStyle(fontSize: 12),
                    textAlign: pw.TextAlign.justify,

                  ),
                ),
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Bullet(
                    text: " Email: ${mouData.orgEmail.trim()}",
                    style: pw.TextStyle(fontSize: 12),
                    textAlign: pw.TextAlign.justify,

                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text(
                    "2. Mindbend SVNIT",
                    style: pw.TextStyle(
                        fontSize: 12, fontWeight: pw.FontWeight.bold),
                    textAlign: pw.TextAlign.justify,

                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Bullet(
                    text:
                    " Address: Ichchhanath Surat- Dumas Road, Keval Chowk, Surat, Gujarat 395007",
                    style: pw.TextStyle(fontSize: 12),
                    textAlign: pw.TextAlign.justify,

                  ),
                ),
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Bullet(
                    text: " Email: mindbend@svnit.ac.in",
                    style: pw.TextStyle(fontSize: 12),
                    textAlign: pw.TextAlign.justify,

                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Row(children: [
                  pw.Align(
                    alignment: pw.Alignment.topLeft,
                    child: pw.Text(
                      "Purpose:",
                      style: pw.TextStyle(
                          fontSize: 12, fontWeight: pw.FontWeight.bold),
                      textAlign: pw.TextAlign.justify,

                    ),
                  ),
                  pw.Align(
                    alignment: pw.Alignment.topLeft,
                    child: pw.Text(
                        "To outline the terms of collaboration for a successful campaign.",textAlign: pw.TextAlign.justify,
                    ),

                  ),
                ]),

                pw.SizedBox(height: 20),
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text(
                    "Scope of Collaboration: ",
                    textAlign: pw.TextAlign.justify,

                    style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text(
                    textAlign: pw.TextAlign.justify,

                    "To establish a partnership between ${mouData.orgName} and Mindbend for the event of Mindbend 2025.",
                    style: pw.TextStyle(fontSize: 12),
                  ),
                ),
                pw.SizedBox(height: 20),

                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text(
                    textAlign: pw.TextAlign.justify,

                    "Deliverables from ${mouData.orgName}",
                    style: pw.TextStyle(
                        fontSize: 12, fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.SizedBox(height: 10),
                // Loop through orgPromised and mbPromised and create bullets
                ...mouData.orgPromised.map((promise) {
                  return pw.Align(
                    alignment: pw.Alignment.topLeft,
                    child: pw.Bullet(textAlign: pw.TextAlign.justify,
                        text: promise.trim()),
                  );
                }).toList(),
                pw.SizedBox(height: 10),
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text(
                    textAlign: pw.TextAlign.justify,

                    "Deliverables from Mindbend: ",
                    style: pw.TextStyle(
                        fontSize: 12, fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.SizedBox(height: 10),
                // Loop through mbPromised and create bullets
                ...mouData.mbPromised.map((promise) {
                  return pw.Align(
                    alignment: pw.Alignment.topLeft,
                    child: pw.Bullet(textAlign: pw.TextAlign.justify,
                        text: promise.trim()),
                  );
                }).toList(),

                pw.SizedBox(height: 10),
                pw.SizedBox(height: 10),
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text(
                    textAlign: pw.TextAlign.justify,

                    "Amendments:",
                    style: pw.TextStyle(
                        fontSize: 12, fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.SizedBox(height: 10),

                // Use Bullet points from the 'pdf' package
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Bullet(
                    textAlign: pw.TextAlign.justify,

                    text: "Any amendments to this MOU must be made in writing and signed by both partners.",
                    style: pw.TextStyle(fontSize: 12),
                  ),
                ),
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Bullet(
                    textAlign: pw.TextAlign.justify,

                    text: "This MOU may be terminated by either partner with written notice given to the other partner.",
                    style: pw.TextStyle(fontSize: 12),
                  ),
                ),

                pw.SizedBox(height: 20,),

                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text(
                    textAlign: pw.TextAlign.justify,

                    "Duration:",
                    style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text(
                    textAlign: pw.TextAlign.justify,

                    "This MOU shall remain in effect for the duration of the scheduled event until ${mouData.lastValidDate}.",
                    style: pw.TextStyle(fontSize: 12),
                  ),
                ),


                pw.SizedBox(height: 20),
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text("Signatures:",
                      style: pw.TextStyle(
                          fontSize: 12, fontWeight: pw.FontWeight.bold)),
                ),
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text(
                    textAlign: pw.TextAlign.justify,

                    "By signing below, the parties agree to the terms outlined in this MOU",
                    style: pw.TextStyle(fontSize: 12),
                  ),
                ),
                pw.SizedBox(height: 60),
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text(
                      "${mouData.orgName}           Yug Rana         Dr.A.K.Mungray          Dr.S.R.Patel"),
                ),
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text(
                      "                           CCAS               Chairperson                Dean Sw"),
                ),
              ],
            ),
          )
        ],
      ),
    );

    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    if (!(Platform.isAndroid ||
        Platform.isIOS ||
        Platform.isMacOS ||
        Platform.isWindows)) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Preview MOU Document"),
        ),
        body: const Center(
          child: Text('PDF preview not supported on this platform.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Preview MOU Document"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: PdfPreview(
        build: (format) => _buildPdf(format),
        canChangePageFormat: false,
        pdfFileName: 'MOU_${mouData.orgName}.pdf',
        allowPrinting: true,
        allowSharing: true,
        initialPageFormat: PdfPageFormat.a4,
        // Explicitly set page format to A4
        useActions: true,
        onPrinted: (context)async{
          final row = [
            mouData.date.toString(),
            "MOU",
            mouData.orgName,
            "+10000"
          ];
          await GsheetsApi.insert(row);
        },
      ),
    );
  }
}