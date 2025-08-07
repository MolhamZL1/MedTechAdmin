import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med_tech_admin/core/functions/get_vedio_duration.dart';

import '../../../../domain/entities/vedio_entity.dart';
import 'ShowVedioDialog.dart';

class VedioItem extends StatefulWidget {
  const VedioItem({super.key, required this.vedioEntity});
  final VedioEntity vedioEntity;

  @override
  State<VedioItem> createState() => _VedioItemState();
}

class _VedioItemState extends State<VedioItem> {
  Duration? duration;

  @override
  void initState() {
    super.initState();
    _loadDuration();
  }

  Future<void> _loadDuration() async {
    final result = await getVideoDurationFromUrl(widget.vedioEntity.url);
    if (mounted) {
      setState(() {
        duration = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: ListTile(
        leading: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder:
                  (context) => ShowVedioDialog(vedioEntity: widget.vedioEntity),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(4),
            ),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            child: Icon(FontAwesomeIcons.play, color: Colors.white, size: 16),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(
            widget.vedioEntity.name,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        subtitle: Text(
          widget.vedioEntity.description,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
            SizedBox(width: 4),
            Text(
              duration == null
                  ? '--:--'
                  : '${duration!.inMinutes}:${(duration!.inSeconds % 60).toString().padLeft(2, '0')}',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
