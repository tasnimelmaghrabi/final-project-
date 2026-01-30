import 'package:flutter/material.dart';
import 'package:gymunity/screens/ass_13.dart';
import 'package:gymunity/widget/custom_button.dart';

void showAllSupplements(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, controller) {
        return AllSupplementsSheet(scrollController: controller);
      },
    ),
  );
}

class AllSupplementsSheet extends StatefulWidget {
  final ScrollController scrollController;

  const AllSupplementsSheet({Key? key, required this.scrollController})
      : super(key: key);

  @override
  State<AllSupplementsSheet> createState() => _AllSupplementsSheetState();
}

class _AllSupplementsSheetState extends State<AllSupplementsSheet> {
  final List<String> allSupplements = [
    "Protein", "BCAAs", "Vitamin D", "Tumeric",
    "Whey", "Green Tea Extract", "Magnesium", "Iron", "Multi-Vitamin", "Omega-3",
    "Omega 8", "Vitamin B", "Vitamin C", "Beta-Alanine", "Fiber", "Omega 12",
    "Omega 2", "Curcumin", "Creatine", "Creatine HCL", "Zinc", "Ashwagandha",
    "Vitamin A", "Probiotics", "Calcium", "Pre-Workout", "Fish Oil", "Collagen",
    "EAA", "L-Carnitine", "L-Arginine", "Melatonin", "Biotin", "K2 + D3", "CoQ10",
    "Glutamine", "Sodium", "Potassium", "Chromium"
  ];

  String query = '';
  late List<String> visibleList;
  final Set<String> selected = {};

  @override
  void initState() {
    super.initState();
    visibleList = List.from(allSupplements);
  }

  void updateQuery(String q) {
    setState(() {
      query = q.trim();
      if (query.isEmpty) {
        visibleList = List.from(allSupplements);
      } else {
        final qLower = query.toLowerCase();
        final startsWith = allSupplements.where((s) => s.toLowerCase().startsWith(qLower)).toList();
        final contains = allSupplements.where((s) =>
          !s.toLowerCase().startsWith(qLower) &&
          s.toLowerCase().contains(qLower)).toList();
        final others = allSupplements.where((s) =>
          !s.toLowerCase().contains(qLower) &&
          !s.toLowerCase().startsWith(qLower)).toList();

        visibleList = [...startsWith, ...contains, ...others];
      }
    });
  }

  void toggleSelect(String item) {
    setState(() {
      if (selected.contains(item)) {
        selected.remove(item);
      } else {
        selected.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            SizedBox(height: 12),
            Container(
              width: 60,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),

            SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'All Supplements',
                style: TextStyle(
                  fontFamily: "Work Sans",
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Color(0xffF3F3F4),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: Color(0xffF97316), width: 1),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: updateQuery,
                        decoration: InputDecoration(
                          hintText: 'Search supplements...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(Icons.search),
                  ],
                ),
              ),
            ),

            SizedBox(height: 14),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: ListView.separated(
                  controller: widget.scrollController,
                  itemCount: visibleList.length,
                  separatorBuilder: (_, __) => SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final item = visibleList[index];
                    final isSelected = selected.contains(item);

                    return GestureDetector(
                      onTap: () => toggleSelect(item),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 180),
                        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                        decoration: BoxDecoration(
                          color: isSelected ? Color(0xff2563EB) : Color(0xffF3F3F4),
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: Color(0xffF3F3F4).withOpacity(0.5),
                                    blurRadius: 12,
                                    offset: Offset(4, 4),
                                  ),
                                ]
                              : [],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                item,
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: isSelected ? Colors.white : Color(0xff393C43),
                                ),
                              ),
                            ),
                            Container(
                              width: 23,
                              height: 23,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: isSelected ? Colors.white : Colors.transparent,
                                border: Border.all(
                                  color: isSelected ? Colors.white : Colors.grey.shade500,
                                  width: 2,
                                ),
                              ),
                              child: isSelected
                                  ? Center(
                                      child: Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          border: Border.all(
                                            color: Color(0xff2563EB),
                                            width: 3,
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            SizedBox(height: 8),

            if (selected.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6),
                child: Row(
                  children: [
                    Text("Selected"),
                    SizedBox(width: 8),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: selected.map((s) {
                            return Container(
                              margin: EdgeInsets.only(right: 8),
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: Color(0xffDBEAFE),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    s,
                                    style: TextStyle(
                                      color: Color(0xff2563EB),
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  GestureDetector(
                                    onTap: () => toggleSelect(s),
                                    child: Container(
                                      width: 18,
                                      height: 18,
                                      alignment: Alignment.center,
                                      color: Colors.transparent,
                                      child: Icon(
                                        Icons.close,
                                        size: 14,
                                        color: Color(0xff2563EB),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            CustomButton(
              text: 'Apply ✓',
              onTap: () {
                print("Selected Supplements: $selected");
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>CalorieGoalPage() ),
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}
