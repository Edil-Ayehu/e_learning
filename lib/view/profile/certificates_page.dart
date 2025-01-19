import 'package:flutter/material.dart';

class CertificatesPage extends StatelessWidget {
  const CertificatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Certificates'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _getCertificates().length,
        itemBuilder: (context, index) {
          final certificate = _getCertificates()[index];
          return _buildCertificateCard(context, certificate);
        },
      ),
    );
  }

  Widget _buildCertificateCard(BuildContext context, Certificate certificate) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              image: DecorationImage(
                image: NetworkImage(certificate.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  certificate.courseName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Completed on ${certificate.completionDate}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      icon: const Icon(Icons.download),
                      label: const Text('Download'),
                      onPressed: () => _downloadCertificate(certificate),
                    ),
                    TextButton.icon(
                      icon: const Icon(Icons.share),
                      label: const Text('Share'),
                      onPressed: () => _shareCertificate(certificate),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Certificate> _getCertificates() {
    return [
      Certificate(
        courseName: 'Flutter Development Masterclass',
        completionDate: '15 Mar 2024',
        imageUrl: 'https://picsum.photos/400/200',
      ),
      Certificate(
        courseName: 'UI/UX Design Fundamentals',
        completionDate: '28 Feb 2024',
        imageUrl: 'https://picsum.photos/400/201',
      ),
    ];
  }

  void _downloadCertificate(Certificate certificate) {
    // Implement certificate download
  }

  void _shareCertificate(Certificate certificate) {
    // Implement certificate sharing
  }
}

class Certificate {
  final String courseName;
  final String completionDate;
  final String imageUrl;

  Certificate({
    required this.courseName,
    required this.completionDate,
    required this.imageUrl,
  });
}
