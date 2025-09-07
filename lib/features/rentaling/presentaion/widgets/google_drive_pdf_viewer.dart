import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/utils/app_colors.dart';
import '../../domain/entities/contract-entity.dart';
import 'pdf_viewer_widget.dart';

class GoogleDrivePdfViewer extends StatelessWidget {
  final ContractEntity contract;
  
  const GoogleDrivePdfViewer({
    super.key,
    required this.contract,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.cardColorDark
              : AppColors.cardColorlight,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header Bar (Google Drive style)
            _buildHeaderBar(context),
            
            // PDF Viewer Content
            Expanded(
              child: PdfViewerWidget(
                pdfUrl: contract.contractDocumentUrl,
                contractNumber: contract.contractNumber,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderBar(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.cardColorDark
            : AppColors.cardColorlight,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: Row(
        children: [
          // File Icon and Name
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.cardColorDark
                  : AppColors.cardColorlight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.picture_as_pdf,
              color: Colors.red[600],
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'contract-${contract.contractNumber}.pdf',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Rental Contract Document',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          
          // Action Buttons
          _buildActionButton(
            icon: Icons.download,
            tooltip: 'Download',
            onPressed: () => _downloadPdf(),
          ),
          _buildActionButton(
            icon: Icons.open_in_browser,
            tooltip: 'Open in Browser',
            onPressed: () => _openInBrowser(),
          ),
          _buildActionButton(
            icon: Icons.share,
            tooltip: 'Share',
            onPressed: () => _sharePdf(context),
          ),
          _buildActionButton(
            icon: Icons.info_outline,
            tooltip: 'Details',
            onPressed: () => _showDetails(context),
          ),
          const SizedBox(width: 8),
          Container(
            width: 1,
            height: 32,
            color:Theme.of(context).brightness == Brightness.dark
                ? AppColors.cardColorDark
                : AppColors.cardColorlight,
          ),
          const SizedBox(width: 8),
          _buildActionButton(
            icon: Icons.close,
            tooltip: 'Close',
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            size: 20,
            color: Colors.grey[700],
          ),
        ),
      ),
    );
  }

  void _downloadPdf() async {
    final fullUrl = 'http://localhost:8383${contract.contractDocumentUrl}';
    if (await canLaunch(fullUrl)) {
      await launch(fullUrl);
    }
  }

  void _openInBrowser() async {
    final fullUrl = 'http://localhost:8383${contract.contractDocumentUrl}';
    if (await canLaunch(fullUrl)) {
      await launch(fullUrl);
    }
  }

  void _sharePdf(BuildContext context) {
    final fullUrl = 'http://localhost:8383${contract.contractDocumentUrl}';
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Share Contract'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Share this contract document:'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.cardColorDark
                    : AppColors.cardColorlight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: SelectableText(
                fullUrl,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              // Copy to clipboard functionality would go here
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Link copied to clipboard')),
              );
            },
            child: const Text('Copy Link'),
          ),
        ],
      ),
    );
  }

  void _showDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Contract Details'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailItem(context,'Contract Number', contract.contractNumber),
              _buildDetailItem(context,'Customer', contract.user.username),
              _buildDetailItem(context,'Email', contract.user.email),
              _buildDetailItem(context,'Product', contract.product.nameEn),
              _buildDetailItem(context,'Status', contract.status),
              _buildDetailItem(context,'Start Date', _formatDate(contract.startDate)),
              _buildDetailItem(context,'End Date', _formatDate(contract.endDate)),
              _buildDetailItem(context,'Created', _formatDate(contract.createdAt)),
              _buildDetailItem(context,'Last Updated', _formatDate(contract.updatedAt)),
              if (contract.notes != null && contract.notes!.isNotEmpty)
                _buildDetailItem(context,'Notes', contract.notes!),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(BuildContext context,String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style:  Theme.of(context).textTheme.headlineLarge,

            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}

// Function to show the Google Drive style PDF viewer
void showGoogleDrivePdfViewer(BuildContext context, ContractEntity contract) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => GoogleDrivePdfViewer(contract: contract),
  );
}

