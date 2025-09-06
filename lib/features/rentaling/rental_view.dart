import 'package:flutter/material.dart';
import 'package:med_tech_admin/features/rentaling/presentaion/views/contracts_view.dart';
import 'package:med_tech_admin/features/rentaling/presentaion/widgets/rentals_view_body.dart';


class RentalView extends StatelessWidget {
  const RentalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 500,
        height: 900,
        child: const ContractsView());
  }
}
