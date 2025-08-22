import 'package:flutter/material.dart';



class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return
       Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Company Offers',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'View All Offers',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Offers List
            Expanded(
              child: ListView(
                children: [
                  OfferCard(
                    title: 'X-Ray Machine Digital',
                    description: 'High-resolution digital X-ray system',
                    price: '\$540,000',
                    growth: '+15%',
                    imagePath: 'assets/images/1.jpg',
                  ),
                  const SizedBox(height: 16),
                  OfferCard(
                    title: 'Ultrasound Scanner',
                    description: 'Advanced ultrasound imaging device',
                    price: '\$280,000',
                    growth: '+8%',
                    imagePath: 'assets/images/2.jpg',
                  ),
                  const SizedBox(height: 16),
                  OfferCard(
                    title: 'Patient Monitor',
                    description: 'Multi-parameter patient monitoring system',
                    price: '\$200,000',
                    growth: '+22%',
                    imagePath: 'assets/images/3.png',
                  ),
                  const SizedBox(height: 16),
                  OfferCard(
                    title: 'Ventilator ICU',
                    description: 'Intensive care ventilation system',
                    price: '\$150,000',
                    growth: '+5%',
                    imagePath: 'assets/images/4.jpg',
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  }
}

class OfferCard extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final String growth;
  final String imagePath;

  const OfferCard({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.growth,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.blue[50],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(

                    child: const Icon(
                      Icons.medical_services,
                      color: Colors.blue,
                      size: 30,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          // Price and Growth
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                growth,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
