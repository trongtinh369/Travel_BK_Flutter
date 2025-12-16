import 'package:booking_tour_flutter/app/route_manager.dart';
import 'package:flutter/material.dart';

class DrawerBar extends StatelessWidget {
  const DrawerBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF23A892)),
            child: Text(
              'BooKing Tour',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          ListTile(
            onTap: () => {Navigator.pushNamed(context, RouteName.tripList)},
            leading: Icon(Icons.route),
            title: Text("Chuyến đi"),
          ),
          ListTile(
            onTap:
                () => {
                  Navigator.pushNamed(context, RouteName.scheduleTourmanager),
                },
            leading: Icon(Icons.calendar_today),
            title: Text("Lịch trình"),
          ),
          ListTile(
            onTap: () => {Navigator.pushNamed(context, RouteName.assignment)},
            leading: Icon(Icons.person_pin_circle),
            title: Text("Phân công"),
          ),
          ListTile(
            onTap:
                () => {Navigator.pushNamed(context, RouteName.danhSachDiaDanh)},
            leading: Icon(Icons.place_outlined),
            title: Text("Địa danh"),
          ),
          ListTile(
            onTap: () => {Navigator.pushNamed(context, RouteName.hoatDong)},
            leading: Icon(Icons.group),
            title: Text("Hoạt động"),
          ),
          // ListTile(
          //   onTap: () => {print("Hello")},
          //   leading: Icon(Icons.local_taxi),
          //   title: Text("Địa điểm hoạt động"),
          // ),
        ],
      ),
    );
  }
}
