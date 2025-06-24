import 'package:flutter/material.dart';
import 'package:med_tech_admin/core/widgets/responsive.dart';

import '../../../domain/entities/InfoCardEntity.dart';
import 'CustomInfoCard.dart';

class InfoCardList extends StatelessWidget {
  const InfoCardList({super.key, required this.entities});
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
                child: CustomInfoCard(
                  color: entities[index].color,
                  text: entities[index].text,
                  count: entities[index].count,
                  icon: entities[index].icon,
                ),
              ),
            ),
          ),
        )
        : Column(
          children: List.generate(
            entities.length,
            (index) => Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: CustomInfoCard(
                color: entities[index].color,
                text: entities[index].text,
                count: entities[index].count,
                icon: entities[index].icon,
              ),
            ),
          ),
        );
  }
}
