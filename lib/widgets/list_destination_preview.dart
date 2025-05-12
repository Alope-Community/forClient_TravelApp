import 'package:flutter/material.dart';
import 'package:forclient_travelapp/models/destination.dart';
import 'package:forclient_travelapp/screens/detail.dart';
import 'package:forclient_travelapp/utils/constant.dart';
import 'package:forclient_travelapp/widgets/horizontal_card.dart';
import 'package:forclient_travelapp/widgets/vertical_card.dart';

class ListDestinationPreview extends StatefulWidget {
  final String selectedCategory;
  final Future<List<Destination>> future;
  final bool isRecomendation;

  const ListDestinationPreview({
    required this.selectedCategory,
    required this.future,
    required this.isRecomendation,
    super.key,
  });

  @override
  State<ListDestinationPreview> createState() => _ListDestinationPreviewState();
}

class _ListDestinationPreviewState extends State<ListDestinationPreview> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
              strokeWidth: 1,
            ),
          );
        } else if (snapshot.hasError) {
          return SizedBox(
            height: 220,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text(
                  "Terjadi Kesalahan 😓",
                  style: AppTextStyles.heading3,
                ),
              ),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return SizedBox(
            height: 220,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text('Tidak ada data 😔', style: AppTextStyles.heading3),
              ),
            ),
          );
        } else {
          return widget.isRecomendation
              ? ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                separatorBuilder: (context, index) => SizedBox(height: 15),
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = snapshot.data![index];
                  return HorizontalCard(
                    imageUrl: item.images[0].toString(),
                    title: item.name.toString(),
                    rating: item.rating.toString(),
                    category: item.category.toString(),
                    price: item.budget.toString(),
                  );
                },
              )
              : SizedBox(
                height: 220,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  separatorBuilder: (context, index) => SizedBox(width: 15),
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data![index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(destination: item),
                          ),
                        );
                      },
                      child: VerticalCard(
                        imageUrl: item.images[0].toString(),
                        title: item.name.toString(),
                        rating: item.rating.toString(),
                        category: item.category.toString(),
                        price: item.budget.toString(),
                      ),
                    );
                  },
                ),
              );
        }
      },
    );
  }
}
