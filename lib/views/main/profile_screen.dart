import 'package:flutter/material.dart';
import 'package:online_groceries_app/components/custom_show_dialog.dart';
import 'package:online_groceries_app/components/my_button.dart';
import 'package:online_groceries_app/utils/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(kDefualtPaddin),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage(
                        'assets/images/profilepic.png',
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SIGMA BOY',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                      ),
                      Text(
                        'vichea@gmail.com',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 15),
                  Icon(Icons.edit_outlined, color: kPrimaryColor),
                ],
              ),
            ),
            Divider(color: Theme.of(context).colorScheme.secondary),
            Expanded(
              child: ListView(
                children: [
                  buildListTile(context, 'assets/icons/order.png', 'Orders'),
                  buildListTile(
                    context,
                    'assets/icons/detail-card.png',
                    'My Details',
                  ),
                  buildListTile(
                    context,
                    'assets/icons/location.png',
                    'Delivery Address',
                  ),
                  buildListTile(
                    context,
                    'assets/icons/payment.png',
                    'Payment Methods',
                  ),
                  buildListTile(
                    context,
                    'assets/icons/promo.png',
                    'Promo Code',
                  ),
                  buildListTile(
                    context,
                    'assets/icons/notification.png',
                    'Notifications',
                  ),
                  buildListTile(context, 'assets/icons/help.png', 'Help'),
                  buildListTile(context, 'assets/icons/about.png', 'About'),
                ],
              ),
            ),
            MyButton(
              icon: Icon(Icons.exit_to_app, size: 20, color: kPrimaryColor),
              onPressed: () {
                CustomShowDialog.show(context, () {
                  Navigator.pop(context);
                });
              },
              text: 'Log out',
              textColor: kPrimaryColor,
              color: Theme.of(context).colorScheme.surface,
              padding: EdgeInsets.symmetric(horizontal: kDefualtPaddin),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget buildListTile(BuildContext context, String icon, String title) {
    return Column(
      children: [
        ListTile(
          leading: Image.asset(
            icon,
            width: 30,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          title: Text(title, style: TextStyle(fontSize: 15)),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          onTap: () {},
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefualtPaddin),
          child: Divider(
            color: Theme.of(context).colorScheme.secondary,
            height: 0.8,
          ),
        ),
      ],
    );
  }
}
