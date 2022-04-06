import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";

// import 'package:flutter_user_login_reg/widgets/degreeCard.dart';
// import 'package:flutter_user_login_reg/widgets/events_Info_widget.dart';
// import 'package:flutter_user_login_reg/widgets/news_Info_widget.dart';

import '../model/user_model.dart';
import '../services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPage = 0;
  PageController pageController = PageController();

  //authservice
  final AuthService _auth = AuthService();
  user_model currentUser = user_model();

  @override
  void initState() {
    // init state
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .get()
        .then((val) {
      setState(() {
        currentUser = user_model.fromMap(val.data());
      });
    });
  }

  List<_Photo> _photos(BuildContext context) {
    return [
      _Photo(
          assetName: 'assets/images/computing.jpg',
          title: "COMPUTING",
          subtitle: "Local & International",
          tileColor: 0xff053769),
      _Photo(
          assetName: 'assets/images/engineering.jpg',
          title: "ENGINEERING",
          subtitle: "Local & International",
          tileColor: 0xff2A8945),
      _Photo(
          assetName: 'assets/images/business.jpg',
          title: "BUSINESS",
          subtitle: "Local & International",
          tileColor: 0xffAA0B38),
      _Photo(
          assetName: 'assets/images/humantise.jpg',
          title: "HUMANTISE & SCI",
          subtitle: "International",
          tileColor: 0xff873E8D),
      _Photo(
          assetName: 'assets/images/graduate.jpg',
          title: "POSTGRADUATE",
          subtitle: "Local & International",
          tileColor: 0xffED9736),
      _Photo(
          assetName: 'assets/images/archi.jpg',
          title: "ARCHITECTURE",
          subtitle: "International",
          tileColor: 0xff009FE3),
      _Photo(
          assetName: 'assets/images/hospitality.jpg',
          title: "HOSPITALITY",
          subtitle: "International",
          tileColor: 0xffF5821F),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "popcorn",
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.w600, fontSize: 25),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout_rounded,
              color: Colors.orange,
              size: 35,
            ),
            onPressed: () {
              _auth.signOut();
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Signed Out Successfully')));
              Navigator.pushReplacementNamed(context, '/');
            },
            padding: const EdgeInsets.only(right: 10),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/userprofile');
            },
            child: Padding(
                padding: EdgeInsets.all(9.0),
                child: currentUser.imagePath != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(currentUser.imagePath!),
                      )
                    : const CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://firebasestorage.googleapis.com/v0/b/sliit-info-ctse.appspot.com/o/uploads%2Fimages.jpeg?alt=media&token=26ec85c5-b045-45da-8b57-05332a9b6665'),
                      )),
          ),
        ],
      ),
      body: PageView(
        controller: pageController,
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              // child: GridView.count(
              //   restorationId: 'grid_view_demo_grid_offset',
              //   crossAxisCount: 2,
              //   mainAxisSpacing: 8,
              //   crossAxisSpacing: 8,
              //   padding: const EdgeInsets.all(8),
              //   childAspectRatio: 1,
              //   children: _photos(context).map<Widget>((photo) {
              //     return _GridDemoPhotoItem(
              //       photo: photo,
              //     );
              //   }).toList(),
              // ),
            ),
          ),
          Column(
            children: const [
              Padding(
                padding: EdgeInsets.fromLTRB(1, 5, 1, 5),
                child: Text(
                  'Events',
                  style: TextStyle(fontSize: 26),
                ),
              ),
              //Expanded(child: eventInfo()),
            ],
          ),
          Column(
            children: const [
              Padding(
                padding: EdgeInsets.fromLTRB(1, 5, 1, 5),
                child: Text(
                  'News',
                  style: TextStyle(fontSize: 26),
                ),
              ),
              //Expanded(child: newsInfo()),
            ],
          ),
          Column(
            children: const [
              Padding(
                padding: EdgeInsets.fromLTRB(1, 5, 1, 5),
                child: Text(
                  'Lectures',
                  style: TextStyle(fontSize: 26),
                ),
              ),
              //Expanded(child: lecturersInfo()),
            ],
          ),
        ],
      ),
      floatingActionButton: currentUser.acc_type == 'Admin'
          ? FloatingActionButton(
              onPressed: () {
                // print(currentUser.acc_type);
                Navigator.pushNamed(context, '/admin');
                // Add your onPressed code here!
              },
              backgroundColor: const Color(0xff002F66),
              child: const Icon(
                Icons.admin_panel_settings_sharp,
                color: Colors.white,
              ),
            )
          : currentUser.acc_type == 'Student'
              ? FloatingActionButton(
                  onPressed: () {
                    // print(currentUser.acc_type);
                    Navigator.pushNamed(context, '/inquiries');
                    //  onPressed code here!
                  },
                  backgroundColor: const Color(0xff002F66),
                  child: const Icon(
                    Icons.question_answer,
                    color: Colors.white,
                  ),
                )
              : null,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.graduationCap), label: 'Faculties'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.calendarDays), label: 'Events'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.newspaper), label: 'News'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.person), label: 'Staff'),
        ],
        currentIndex: _selectedPage,
        onTap: onTapped,
      ),
    );
  }

  void onTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 1000), curve: Curves.easeIn);
  }
}

class _Photo {
  _Photo({
    required this.assetName,
    required this.title,
    required this.subtitle,
    required this.tileColor,
  });

  final String assetName;
  final String title;
  final String subtitle;
  final int tileColor;
}

/// Allow the text size to shrink to fit in the space
class _GridTitleText extends StatelessWidget {
  const _GridTitleText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: AlignmentDirectional.centerStart,
      child: Text(text),
    );
  }
}

// class _GridDemoPhotoItem extends StatelessWidget {
//   const _GridDemoPhotoItem({
//     Key? key,
//     required this.photo,
//   }) : super(key: key);

//   final _Photo photo;

//   @override
//   Widget build(BuildContext context) {
//     final Widget image = Material(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
//       clipBehavior: Clip.antiAlias,
//       child: Image.asset(
//         photo.assetName,
//         fit: BoxFit.cover,
//       ),
//     );

//     return GestureDetector(
//       onTap: () => Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (BuildContext context) =>
//                   degreeInfo(faculty: photo.title))),
//       child: GridTile(
//         footer: Material(
//           color: Colors.transparent,
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
//           ),
//           clipBehavior: Clip.antiAlias,
//           child: GridTileBar(
//             backgroundColor: Color(photo.tileColor),
//             title: _GridTitleText(photo.title),
//             subtitle: _GridTitleText(photo.subtitle),
//           ),
//         ),
//         child: image,
//       ),
//     );
//   }
// }
