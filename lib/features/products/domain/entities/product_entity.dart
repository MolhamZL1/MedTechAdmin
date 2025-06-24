class ProductEntity {
  final String id;
  final String imageUrl;
  final String name;
  final String category;
  final num salePrice;
  final num rentalPrice;
  final int stock;
  final String status;

  ProductEntity({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.category,
    required this.salePrice,
    required this.rentalPrice,
    required this.stock,
    required this.status,
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
  ),
];
