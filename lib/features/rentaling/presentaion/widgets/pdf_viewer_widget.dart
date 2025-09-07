import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;

import '../../../../core/utils/app_colors.dart';

class PdfViewerWidget extends StatefulWidget {
  final String pdfUrl;
  final String contractNumber;
  
  const PdfViewerWidget({
    super.key,
    required this.pdfUrl,
    required this.contractNumber,
  });

  @override
  State<PdfViewerWidget> createState() => _PdfViewerWidgetState();
}

class _PdfViewerWidgetState extends State<PdfViewerWidget> {
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  void _loadPdf() {
    // Simulate loading time
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.cardColorDark
            : AppColors.cardColorlight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: _isLoading
          ? _buildLoadingState()
          : _hasError
              ? _buildErrorState()
              : _buildPdfViewer(),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text(
            'Loading PDF...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red[300],
          ),
          const SizedBox(height: 16),
          const Text(
            'Failed to load PDF',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Please try again or open in browser',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                    _hasError = false;
                  });
                  _loadPdf();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: _openInBrowser,
                icon: const Icon(Icons.open_in_browser),
                label: const Text('Open in Browser'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPdfViewer() {
    return Column(
      children: [
        // PDF Toolbar (similar to Google Drive)
        Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.cardColorDark
                : AppColors.cardColorlight,
            border: Border(
              bottom: BorderSide(color: Colors.grey[300]!),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.picture_as_pdf, color: Colors.red, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'contract-${widget.contractNumber}.pdf',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                onPressed: _downloadPdf,
                icon: const Icon(Icons.download),
                tooltip: 'Download',
              ),
              IconButton(
                onPressed: _openInBrowser,
                icon: const Icon(Icons.open_in_browser),
                tooltip: 'Open in Browser',
              ),
              IconButton(
                onPressed: _printPdf,
                icon: const Icon(Icons.print),
                tooltip: 'Print',
              ),
            ],
          ),
        ),
        
        // PDF Content Area
        Expanded(
          child: Container(
            width: double.infinity,
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.cardColorDark
                : AppColors.cardColorlight,
            child: Center(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.cardColorDark
                      : AppColors.cardColorlight,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.picture_as_pdf,
                      size: 120,
                      color: Colors.red[200],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'PDF Document Preview',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Contract: ${widget.contractNumber}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'For web applications, PDF viewing is best handled by the browser.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _openInBrowser,
                          icon: const Icon(Icons.open_in_browser),
                          label: const Text('View in Browser'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        OutlinedButton.icon(
                          onPressed: _downloadPdf,
                          icon: const Icon(Icons.download),
                          label: const Text('Download'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _openInBrowser() async {
    final fullUrl = 'http://localhost:8383${widget.pdfUrl}';
    if (await canLaunch(fullUrl)) {
      await launch(fullUrl);
    }
  }

  void _downloadPdf() async {
    final fullUrl = 'http://localhost:8383${widget.pdfUrl}';
    
    // For web, we can use the browser's download functionality
    html.AnchorElement(href: fullUrl)
      ..setAttribute('download', 'contract-${widget.contractNumber}.pdf')
      ..click();
  }

  void _printPdf() async {
    final fullUrl = 'http://localhost:8383${widget.pdfUrl}';
    if (await canLaunch(fullUrl)) {
      await launch(fullUrl);
    }
  }
}

