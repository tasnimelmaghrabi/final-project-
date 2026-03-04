import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gymunity/screens/WorkoutPage.dart';
import 'package:gymunity/screens/profile.dart';
import 'package:gymunity/screens/storepage.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? firstName;
  String? lastName;
  String? role;
  String? profileImage;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw "No logged in user";

      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        setState(() {
          firstName = data['firstName'] ?? "User";
          lastName = data['lastName'] ?? "";
          role = (data['role'] ?? "user").toString().toLowerCase();
          profileImage = data['profileImage'] ?? "";
        });
      } else {
        firstName = "User";
        lastName = "";
        role = "user";
        profileImage = "";
      }
    } catch (e) {
      firstName = "User";
      lastName = "";
      role = "user";
      profileImage = "";
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget dashboardCard(String title, IconData icon,
      {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.shade100,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 35),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getHomeContent() {
    if (role == null) {
      return const Center(child: Text("Loading..."));
    }

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 175, 154, 199),
                    Color.fromARGB(255, 239, 246, 246),
                  ],
                ),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProfilePage(
                            firstName: firstName ?? "",
                            lastName: lastName ?? "",
                            profileImage: profileImage ?? "",
                            role: role ?? "user",
                          ),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 28,
                      backgroundImage:
                          profileImage != null &&
                                  profileImage!.isNotEmpty
                              ? NetworkImage(profileImage!)
                              : null,
                      child: profileImage == null ||
                              profileImage!.isEmpty
                          ? const Icon(Icons.person,
                              size: 28)
                          : null,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Welcome ",
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                        Text(
                          "$firstName $lastName",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          role!.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            GridView.count(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1.1,
              children: [

                if (role == 'user') ...[
  dashboardCard(
    "Workout",
    Icons.fitness_center,
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const WorkoutPage(),
        ),
      );
    },
  ),

  dashboardCard(
    "Store",
    Icons.store,
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const Storepage(),
        ),
      );
    },
  ),

  dashboardCard(
    "Progress",
    Icons.show_chart,
  ),

  dashboardCard(
    "Nutrition",
    Icons.restaurant,
  ),
],

                if (role == 'coach') ...[
                  dashboardCard(
                      "Trainees", Icons.people),
                  dashboardCard(
                      "Create Plan",
                      Icons.add_circle_outline),
                  dashboardCard(
                      "Sessions",
                      Icons.calendar_today),
                  dashboardCard(
                      "Messages",
                      Icons.message),
                ],

                if (role == 'seller') ...[
                  dashboardCard(
                      "Orders",
                      Icons.shopping_cart),
                  dashboardCard(
                      "Products",
                      Icons.inventory),
                  dashboardCard(
                      "Sales",
                      Icons.bar_chart),
                  dashboardCard(
                      "Analytics",
                      Icons.analytics),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator())
          : getHomeContent(),
    );
  }
}