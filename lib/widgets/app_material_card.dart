//

import 'package:flutter/material.dart';

import '../helpers/styling/styling.dart';
import '../models/material_datails.dart';
import 'popup_widget.dart';

class AppMaterialCard extends StatelessWidget {
  const AppMaterialCard({
    Key? key,
    required this.materials,
  }) : super(key: key);

  final List<MaterialDetails> materials;

  @override
  Widget build(BuildContext context) {
    final first = materials.first;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: PopupWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MaterialFieldRow(label: 'Name', value: first.name),
            MaterialFieldRow(label: 'Code', value: first.code),
            MaterialFieldRow(label: 'barcode', value: first.barcode),
            MaterialFieldRow(label: 'enduser', value: first.enduser),
            MaterialFieldRow(label: 'enduser', value: first.enduser2),
            MaterialFieldRow(label: 'Unit', value: first.unity),
            MaterialFieldRow(label: 'Unit', value: first.unit2),
            const SizedBox(height: 8),
            Expanded(
              child: Column(
                children: [
                  const MaterialInnerTableHeader(),
                  Expanded(
                      child: ListView.builder(
                          itemCount: materials.length,
                          itemBuilder: (context, index) {
                            return MaterialInnerTableRow(
                                material: materials[index]);
                          })),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MaterialInnerTableHeader extends StatelessWidget {
  const MaterialInnerTableHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              'matunit',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Pallet.green,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          SizedBox(
            width: 80,
            child: Text(
              'Store',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Pallet.green,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              'Image',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Pallet.green,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class MaterialInnerTableRow extends StatelessWidget {
  const MaterialInnerTableRow({
    Key? key,
    required this.material,
  }) : super(key: key);

  final MaterialDetails material;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              material.matunit,
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          SizedBox(
            width: 80,
            child: Text(
              material.storeName,
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Expanded(
            child: Text(
              material.image.split('\\').last,
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class MaterialFieldRow extends StatelessWidget {
  const MaterialFieldRow({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Pallet.green,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
