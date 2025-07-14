import 'package:med_tech_admin/features/products/domain/entities/vedio_entity.dart';

class ProductEntity {
  final String id;
  final String imageUrl;
  final String name;
  final String category;
  final num salePrice;
  final num rentalPrice;
  final String description;

  final int stock;
  final String status;
  final List<VedioEntity> vedioEntities;

  ProductEntity({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.category,
    required this.salePrice,
    required this.rentalPrice,
    required this.stock,
    required this.status,
    required this.vedioEntities,
    required this.description,
  });
}

List<ProductEntity> products = [
  ProductEntity(
    id: "1",
    imageUrl:
        "https://th.bing.com/th/id/OIP.qNHes07V8JNysd6QVFeT3AHaE8?r=0&rs=1&pid=ImgDetMain&cb=idpwebp2&o=7&rm=3",
    name: "Product 1",
    category: "Category 1",
    salePrice: 100,
    rentalPrice: 20,
    stock: 10,
    status: "In Stock",
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
    imageUrl:
        "https://th.bing.com/th/id/OIP.qNHes07V8JNysd6QVFeT3AHaE8?r=0&rs=1&pid=ImgDetMain&cb=idpwebp2&o=7&rm=3",
    name: "Product 2",
    category: "Category 1",
    salePrice: 150,
    rentalPrice: 30,
    stock: 10,
    status: "In Stock",
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
    imageUrl:
        "https://th.bing.com/th/id/OIP.qNHes07V8JNysd6QVFeT3AHaE8?r=0&rs=1&pid=ImgDetMain&cb=idpwebp2&o=7&rm=3",
    name: "Product 3",
    category: "Category 1",
    salePrice: 50,
    rentalPrice: 10,
    stock: 5,
    status: "Low Stock",
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
    imageUrl:
        "https://th.bing.com/th/id/OIP.qNHes07V8JNysd6QVFeT3AHaE8?r=0&rs=1&pid=ImgDetMain&cb=idpwebp2&o=7&rm=3",
    name: "Product 4",
    category: "Category 2",
    salePrice: 200,
    rentalPrice: 40,
    stock: 0,
    status: "Out of Stock",
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
