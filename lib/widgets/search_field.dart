import 'package:flutter/material.dart';
import 'package:forclient_travelapp/utils/constant.dart';

class SearchField extends StatefulWidget {
  final TextEditingController queryController;
  final void Function() onReset;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;

  const SearchField({
    required this.onReset,
    required this.queryController,
    required this.onSubmitted,
    required this.onChanged,
    super.key,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return SearchBar(
      trailing:
          widget.queryController.text.isNotEmpty
              ? [
                IconButton(icon: Icon(Icons.close_rounded), onPressed: widget.onReset),
              ]
              : [],
      controller: widget.queryController,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      backgroundColor: WidgetStatePropertyAll(Colors.white),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      leading: Icon(Icons.search_rounded),
      hintText: 'Cari Tempat Wisata',
      hintStyle: WidgetStateProperty.all(
        AppTextStyles.body.copyWith(
          fontWeight: FontWeight.w500,
          color: Colors.grey.shade500,
        ),
      ),
    );
  }
}
