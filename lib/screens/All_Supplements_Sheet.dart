import 'package:flutter/material.dart';
import 'package:gymunity/widget/custom_button.dart';

Future<List<String>?> showAllSupplements(
  BuildContext context,
  List<String> selectedSupplements,
) {
  return showModalBottomSheet<List<String>>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, controller) {
        return AllSupplementsSheet(
          scrollController: controller,
          initialSelected: selectedSupplements,
        );
      },
    ),
  );
}

class AllSupplementsSheet extends StatefulWidget {
  final ScrollController scrollController;
  final List<String> initialSelected;

  const AllSupplementsSheet({
    super.key,
    required this.scrollController,
    required this.initialSelected,
  });

  @override
  State<AllSupplementsSheet> createState() => _AllSupplementsSheetState();
}

class _AllSupplementsSheetState extends State<AllSupplementsSheet> {
  final List<String> allSupplements = [
    "Protein","BCAAs","Vitamin D","Tumeric","Whey","Green Tea Extract",
    "Magnesium","Iron","Multi-Vitamin","Omega-3","Omega 8","Vitamin B",
    "Vitamin C","Beta-Alanine","Fiber","Creatine","Zinc","Ashwagandha",
    "Vitamin A","Probiotics","Calcium","Fish Oil","Collagen","EAA",
    "L-Carnitine","L-Arginine","Melatonin","Biotin","K2 + D3",
    "CoQ10","Glutamine","Sodium","Potassium","Chromium"
  ];

  late Set<String> selected;
  late List<String> visibleList;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selected = widget.initialSelected.toSet();
    visibleList = List.from(allSupplements);
  }

  void filterSupplements(String query) {
    setState(() {
      if (query.isEmpty) {
        visibleList = List.from(allSupplements);
      } else {
        visibleList = allSupplements
            .where((item) =>
                item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void toggleSelect(String item) {
    setState(() {
      selected.contains(item)
          ? selected.remove(item)
          : selected.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 60,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 20),

          const Text(
            "All Supplements",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: searchController,
              onChanged: filterSupplements,
              decoration: InputDecoration(
                hintText: "Search supplement...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: const Color(0xffF3F3F4),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          Expanded(
            child: ListView.separated(
              controller: widget.scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: visibleList.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (_, index) {
                final item = visibleList[index];
                final isSelected = selected.contains(item);

                return GestureDetector(
                  onTap: () => toggleSelect(item),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xff2563EB)
                          : const Color(0xffF3F3F4),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            item,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (isSelected)
                          const Icon(Icons.check, color: Colors.white),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          CustomButton(
            text: "Apply ✓",
            onTap: () {
              Navigator.pop(context, selected.toList());
            },
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
