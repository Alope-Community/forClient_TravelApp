import 'package:flutter/material.dart';
import 'package:forclient_travelapp/models/destination.dart';
import 'package:forclient_travelapp/utils/constant.dart';
import 'package:forclient_travelapp/screens/detail.dart';

class WishlistCard extends StatelessWidget {
  final Destination item;
  final VoidCallback onRemove;

  const WishlistCard({super.key, required this.item, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.name!),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        bool dismiss = false;
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                "Yakin ingin menghapus ini dari wishlist?",
                style: AppTextStyles.heading2,
              ),
              actions: [
                ElevatedButton(
                  style: AppButtonStyles.elevatedButtonPrimary.copyWith(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll(AppColors.danger),
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
                  onPressed: () {
                    dismiss = true;
                    Navigator.pop(context);
                  },
                  child: Text("Ya"),
                ),
                OutlinedButton(
                  style: AppButtonStyles.outlinedButtonPrimary.copyWith(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Tidak", style: AppTextStyles.body),
                ),
              ],
            );
          },
        );
        if (dismiss) onRemove();
        return null;
      },
      background: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppColors.danger,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(destination: item),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Row(
            children: [
              SizedBox(
                width: 110,
                height: 120,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  child: Image.network(
                    item.images[0],
                    width: 110,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name!,
                        style: AppTextStyles.heading2.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 14,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              item.location,
                              style: AppTextStyles.small.copyWith(
                                color: Colors.grey,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(
                            item.rating.toString(),
                            style: AppTextStyles.small,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.favorite, color: AppColors.danger),
                onPressed: onRemove,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
