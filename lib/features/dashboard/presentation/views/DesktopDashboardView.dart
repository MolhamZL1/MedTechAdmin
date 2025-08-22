import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med_tech_admin/core/functions/Container_decoration.dart';
import 'package:med_tech_admin/core/services/get_it_service.dart';
import 'package:med_tech_admin/core/utils/app_colors.dart';
import 'package:med_tech_admin/core/widgets/CategoryDropdown.dart';
import 'package:med_tech_admin/features/products/domain/repos/products_repo.dart';
import 'package:med_tech_admin/features/products/presentation/cubits/add%20product/add_product_cubit.dart';
import 'package:med_tech_admin/features/products/presentation/views/widgets/add_product_dialog/add_product_dialog.dart';
import 'package:med_tech_admin/features/users/presentation/views/widgets/HeaderUserView.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart'; // للتحقق من kIsWeb
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/entities/InfoCardEntity.dart';
import '../../../Financial/presentaion/views/widgets/revenue_breakdown_chart.dart';
import '../../../Financial/presentaion/views/widgets/revenue_expenses_chart.dart';
import '../../../products/presentation/cubits/cubit/add_media_cubit.dart';
import '../../../products/presentation/views/widgets/InfoCardList.dart';
import '../../../users/presentation/cubits/user_cubit.dart';
import 'ActionCard.dart';
import 'offer.dart';

class DesktopDashboardView extends StatelessWidget {
  const DesktopDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        HeaderDashboardView(),
        SizedBox(height: 24),
        InfoCardList(entities: dashboardinfolist),
        SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 400,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.cardColorDark
                      : AppColors.cardColorlight,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const RevenueExpensesChart(),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.cardColorDark
                      : AppColors.cardColorlight,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child:Container(
                  width: 600,
                  decoration: containerDecoration(context),
                  padding: EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Image.asset("assets/images/1.jpg",
                              width: 100,
                              height: 100,
                            ),
                            Image.asset("assets/images/logo.png",
                              width: 100,
                              height: 100,
                            ),
                            Image.asset("assets/images/3.jpg",
                              width: 100,
                              height: 100,
                            ),
                            Image.asset("assets/images/4.jpg",
                              width: 100,
                              height: 100,
                            ),
                            Image.asset("assets/images/5.jpg",
                              width: 100,
                              height: 100,
                            ),
                            Image.asset("assets/images/6.jpg",
                              width: 100,
                              height: 100,
                            ),
                            ]

                        ),
                      ),
                      Text(
                        "Quick Actions",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),

                      SizedBox(height: 24),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder:
                                      (context) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider(
                                        create:
                                            (context) => AddProductCubit(
                                          getIt.get<ProductsRepo>(),
                                        ),
                                      ),

                                      BlocProvider(
                                        create: (context) => AddMediaCubit(),
                                      ),
                                    ],
                                    child: ProductAddDialog(),
                                  ),
                                );
                              },
                              child: ActionCard(
                                leadingIcon: Icons.add,
                                trailingIcon: Icons.medical_services,
                                title: "Add new Product",
                                subtitle: "Add medical equipment to inventory",
                                color: AppColors.primary,
                              ),
                            ),
                            SizedBox(width: 10,),
                            ActionCard(
                              leadingIcon: Icons.add,
                              trailingIcon: Icons.medication_outlined,
                              title: "Add new Rental",
                              subtitle: "Add medical rental to inventory",
                              color: AppColors.warning,
                            ),
                            SizedBox(width: 10,),
                            GestureDetector(
                              onTap: () => showAddUserDialog(context,cubit: BlocProvider.of<UserCubit>(context)),
                              child: ActionCard(
                                leadingIcon: Icons.add,
                                trailingIcon: Icons.supervised_user_circle,
                                title: "Add new User",
                                subtitle: "Add user to company employment",
                                color: AppColors.success,

                              ),
                            ),
                            SizedBox(width: 10,),
                            GestureDetector(
                              onTap: () => showAddOfferDialog(context),
                              child: ActionCard(
                                leadingIcon: Icons.add,
                                trailingIcon: Icons.local_offer_sharp,
                                title: "Add New Offer",
                                subtitle: "Add a New Offer for Your Products",
                                color: AppColors.error,

                              ),
                            ),


                          ],
                        ),

                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 24),
    Container(
      margin: const EdgeInsets.only(right: 16),
          width: 500,
      color: Theme.of(context).brightness == Brightness.dark
          ? AppColors.cardColorDark
          : AppColors.cardColorlight,
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      // Header
      Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
       Text(
      'Company Offers',
      style: Theme.of(context).textTheme.headlineLarge,
      ),
      TextButton(
      onPressed: () {},
      child:  Text(
      'View All Offers',
      style: Theme.of(context).textTheme.bodyMedium,
      ),
      ),
      ],
      ),
      const SizedBox(height: 24),
      Column(
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
          imagePath: 'assets/images/5.jpg',
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

      // Offers List

      ],
      ),
    ),


      ],
    );
  }
}


List<InfoCardEntity> dashboardinfolist = [
  InfoCardEntity(
    text: "Total Revenue",
    count: "\$245,670",

    icon: const Icon(
      FontAwesomeIcons.dollarSign,
      color: Colors.green,
      size: 30,
    ),
  ),
  InfoCardEntity(
    text: "Active Rentals",
    count: "156",

    icon: const Icon(Icons.calendar_today_outlined, color: Colors.blueAccent),
  ),
  InfoCardEntity(
    text: "Pending Orders",
    count: "43",
    icon: const Icon(
      Icons.shopping_cart_outlined,
      color: Colors.deepOrangeAccent,
    ),
  ),
  InfoCardEntity(
    text: "Maintenance Requests",
    count: "12",
    icon: const Icon(Icons.build_outlined, color: Colors.deepPurple),
  ),
];

class HeaderDashboardView extends StatefulWidget {
  const HeaderDashboardView({super.key});

  @override
  State<HeaderDashboardView> createState() => _HeaderDashboardViewState();
}

class _HeaderDashboardViewState extends State<HeaderDashboardView> {
  List<String> categories = [
    "Last 7 days",
    "Last 30 days",
    "Last 6 months",
    "Last 1 year",
    "All time",
  ];
  String selected = "Last 6 months";

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          "Dashboard",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      subtitle: Text(
        "Welcome back! Here's what's happening with your medical equipment business.",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: CategoryDropdown(
        categories: categories,
        onChanged: (value) {
          setState(() => selected = value!);
        },
        selected: selected,
      ),
    );
  }
}
Future<void> showAddOfferDialog(BuildContext context) async {
  final TextEditingController _offerController = TextEditingController();
  Uint8List? _webImage; // لتخزين الصورة
  final _formKey = GlobalKey<FormState>();

  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title:  Text("Add New Offer",
            style: Theme.of(context).textTheme.bodyLarge,
            ),
            content: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final pickedFile = await ImagePicker().pickImage(
                          source: ImageSource.gallery,
                        );
                        if (pickedFile != null) {
                          final bytes = await pickedFile.readAsBytes();
                          setState(() {
                            _webImage = bytes;
                          });
                        }
                      },
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                          color:  Theme.of(context).brightness == Brightness.dark
                              ? AppColors.cardColorDark
                              : AppColors.cardColorlight,
                        ),
                        child: _webImage == null
                            ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_a_photo, size: 40, color: Colors.blue),
                              SizedBox(height: 8),
                              Text("Upload Image",

                              ),
                            ],
                          ),
                        )
                            : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.memory(
                            _webImage!,
                            fit: BoxFit.cover,
                            width: 300,  // حددنا عرض ثابت
                            height: 500, // حددنا ارتفاع ثابت
                          ),
                        ),

                      ),
                    ),
                    const SizedBox(height: 16),

                    // حقل النص للعرض
                    TextFormField(
                      controller: _offerController,
                      decoration: const InputDecoration(
                        labelText: "Offer Text",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter the offer text";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_webImage == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please upload an image"),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }
                      // ✅ معالجة البيانات هنا (النص + الصورة)
                      print("Offer Text: ${_offerController.text}");
                      print("Image Bytes Length: ${_webImage!.length}");
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add"),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
