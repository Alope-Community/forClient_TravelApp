import 'package:flutter/material.dart';
import 'package:forclient_travelapp/widgets/modal_bottom_filter.dart';
import 'package:forclient_travelapp/utils/constant.dart';

class FilterButton extends StatelessWidget {
  final dynamic selectedFilter;
  final ValueChanged<dynamic> onSelectedFilter;

  const FilterButton({
    required this.selectedFilter,
    required this.onSelectedFilter,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) {
            return ModalBottomFilter(
              selectedFilter: selectedFilter,
              onSelectedFilter: (filter) {
                onSelectedFilter(filter);
              },
            );
          },
        );
      },
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.tune, color: AppColors.primary),
      ),
    );
  }
}
