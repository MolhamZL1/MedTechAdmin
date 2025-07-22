import 'package:med_tech_admin/features/products/domain/entities/vedio_entity.dart';

class ProductEntity {
  final String id;

  final String nameEn;
  final String nameAr;
  final String category;
  final String company;
  final String description;
  final num rentStock;
  final num saleStock;
  final num salePrice;
  final num rentalPrice;
  final bool availableForRent;
  final bool availableForSale;
  final String qrCode;
  final List<String> imagesUrl;
  final List<VedioEntity> vedioEntities;

  ProductEntity({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.category,
    required this.company,
    required this.description,
    required this.rentStock,
    required this.saleStock,
    required this.salePrice,
    required this.rentalPrice,
    required this.availableForRent,
    required this.availableForSale,
    required this.qrCode,
    required this.imagesUrl,
    required this.vedioEntities,
  });
}

List<ProductEntity> products = [
  ProductEntity(
    id: "1",
    company: "Company 1",
    imagesUrl: ["assets/images/5.jpg"],
    nameEn: "Product 1",
    nameAr: " ",
    category: "Category 1",
    salePrice: 100,
    rentalPrice: 20,
    rentStock: 10,
    saleStock: 10,
    availableForRent: true,
    availableForSale: true,
    qrCode: "123456",
    description: "This is product 1",
    vedioEntities: [
      VedioEntity(
        id: "5",
        name: "vedio 5",
        url:
            "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
        description: "This is vedio 5",
        time: "5:0",
      ),
    ],
  ),
  ProductEntity(
    id: "2",
    company: "Company 2",
    imagesUrl: ["assets/images/1.jpg"],
    nameEn: "Product 2",
    nameAr: " ",
    category: "Category 1",
    salePrice: 150,
    rentalPrice: 30,
    rentStock: 10,
    saleStock: 10,
    availableForRent: true,
    availableForSale: true,
    qrCode: "123456",
    description: "This is product 2",
    vedioEntities: [
      VedioEntity(
        id: "6",
        name: "vedio 6",
        url:
            "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
        description: "This is vedio 6",
        time: "6:0",
      ),
    ],
  ),
  ProductEntity(
    id: "3",
    company: "Company 3",
    imagesUrl: ["assets/images/2.jpg"],
    nameEn: "Product 3",
    nameAr: " ",
    category: "Category 1",
    salePrice: 50,
    rentalPrice: 10,
    rentStock: 5,
    saleStock: 5,
    availableForRent: true,
    availableForSale: true,
    qrCode: "123456",
    description: "This is product 3",
    vedioEntities: [
      VedioEntity(
        id: "7",
        name: "vedio 7",
        url:
            "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
        description: "This is vedio 7",
        time: "7:0",
      ),
    ],
  ),
  ProductEntity(
    id: "4",
    company: "Company 4",
    imagesUrl: ["assets/images/3.jpg"],
    nameEn: "Product 4",
    nameAr: " ",
    category: "Category 2",
    salePrice: 200,
    rentalPrice: 40,
    rentStock: 0,
    saleStock: 0,
    availableForRent: false,
    availableForSale: false,
    qrCode: "123456",
    description: "This is product 4",
    vedioEntities: [
      VedioEntity(
        id: "8",
        name: "vedio 8",
        url:
            "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
        description: "This is vedio 8",
        time: "8:0",
      ),
    ],
  ),
];
