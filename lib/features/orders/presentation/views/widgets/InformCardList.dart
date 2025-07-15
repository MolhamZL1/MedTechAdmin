import 'package:flutter/material.dart';
import 'package:med_tech_admin/core/entities/InfoCardEntity.dart';
import 'package:med_tech_admin/core/widgets/responsive.dart';

import 'CutomInformCard.dart';

class InformCardList extends StatelessWidget {
  InformCardList({super.key, required this.entities});

  final List<InfoCardEntity> entities;
  @override
  Widget build(BuildContext context) {
    return Responsive.isDesktop(context)
        ? Row(
          children: List.generate(
            entities.length,
            (index) => Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 24),
                child: CustomInformCard(infoCardEntity: entities[index]),
              ),
            ),
          ),
        )
        : Column(
          children: List.generate(
            entities.length,
            (index) => Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: CustomInformCard(infoCardEntity: entities[index]),
            ),
          ),
        );
  }
}
