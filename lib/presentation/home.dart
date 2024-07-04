import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studio13/core/router.dart';
import 'package:studio13/presentation/blocs/auth_cubit.dart';
import 'package:studio13/presentation/blocs/login/login_cubit.dart';
import 'package:ticket_clippers/ticket_clippers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  int bottomCurrentIndex = 0;
  final pages = [const CouponPageUI(), const SizedBox(), const SizedBox(), const SizedBox()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: bottomCurrentIndex == 0 ? couponAppBar() : null,
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.black,
          unselectedLabelStyle: const TextStyle(color: Colors.black),
          selectedLabelStyle: TextStyle(color: Colors.red[400]),
          selectedItemColor: Colors.red[400],
          currentIndex: bottomCurrentIndex,
          onTap: (value) {
            setState(() {
              bottomCurrentIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.percent), label: 'Coupons'),
            BottomNavigationBarItem(icon: Icon(Icons.location_on_outlined), label: 'Emergency Services'),
            BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
            BottomNavigationBarItem(icon: Icon(Icons.blur_circular_rounded), label: 'Panic Button'),
          ]),
      body: pages[bottomCurrentIndex],
    );
  }

  AppBar couponAppBar() {
    return AppBar(
      title: const Text('Coupons'),
      centerTitle: true,
      bottom: TabBar(indicatorColor: Colors.blue, labelColor: Colors.blue, unselectedLabelColor: Colors.grey, controller: tabController, tabs: const [
        Tab(
          text: 'NEAR ME',
        ),
        Tab(
          text: 'MAP',
        ),
        Tab(
          text: 'BROWSE',
        ),
        Tab(
          text: 'ONLINE',
        ),
      ]),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 40,
            width: 60,
            color: Colors.deepOrange,
            child: const Center(
              child: Text(
                'SOS',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class CouponPageUI extends StatelessWidget {
  const CouponPageUI({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CouponCard(kms: 2.3434, percentage: 23, name: 'STEERS', assetsPath: 'assets/steers.webp'),
        const CouponCard(kms: 1.235, percentage: 45, name: 'ART GALLERY', assetsPath: 'assets/steers.webp'),
        const Spacer(),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton.small(
                onPressed: () {
                  context.read<LoginCubit>().logOutUser();
                  context.read<AuthCubit>().updateStatus(AuthStatus.unauthenticated);
                  appRouter.refresh();
                },
                child: const Icon(Icons.logout)),
          ),
        )
      ],
    );
  }
}

class CouponCard extends StatelessWidget {
  const CouponCard({
    super.key,
    required this.kms,
    required this.percentage,
    required this.name,
    required this.assetsPath,
  });

  final double kms;
  final int percentage;
  final String name;
  final String assetsPath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: SizedBox(
        height: 150,
        width: MediaQuery.sizeOf(context).width,
        child: Stack(
          children: [
            Column(
              children: [
                ClipPath(
                  clipper: TicketRoundedEdgeClipper(edge: Edge.vertical, radius: 20, position: 0),
                  child: ClipPath(
                    clipper: TicketRoundedEdgeClipper(edge: Edge.vertical, radius: 20, position: 70),
                    child: Card(
                      elevation: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 5),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    '$percentage',
                                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    '%',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  Text(
                                    name,
                                    style: const TextStyle(fontSize: 24, color: Colors.grey, fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Transform.rotate(
                                          angle: 5.4,
                                          child: const Icon(
                                            Icons.send,
                                            size: 14,
                                            color: Colors.blue,
                                          )),
                                      Text(
                                        '${kms}kms',
                                        style: const TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
                              SizedBox(height: 100, width: 100, child: Image.asset(assetsPath))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 64,
              top: 15,
              child: Column(
                children: List.generate(
                    12,
                    (index) => Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            height: 3,
                            width: 1,
                            color: Colors.black,
                          ),
                        )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
