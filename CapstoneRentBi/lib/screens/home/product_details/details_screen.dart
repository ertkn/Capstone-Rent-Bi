import 'package:capstone_rent_bi/screens/home/product/widgets/productpageview.dart';
import 'package:capstone_rent_bi/utilities/constants.dart';
import 'package:capstone_rent_bi/utilities/spacing.dart';
import 'package:capstone_rent_bi/utilities/user_preferences.dart';
import 'package:capstone_rent_bi/widgets/custom_circular_indicator.dart';
import 'package:flutter/material.dart';

part 'widgets/body.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // each product have a color
      backgroundColor: Colors.white,
      // appBar: _buildAppBar(context),
      body: Body(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        IconButton(
          // padding: EdgeInsets.only(right: screenWidthPercentage(context, percentage: 0.0005)),
          //0.0375
          tooltip: 'profile page',
          color: Colors.transparent,
          iconSize: screenWidthPercentage(context, percentage: 0.1),
          // onPressed: () => Navigator.pop(context),
          onPressed: () => Navigator.pushNamed(context, '/userset'),
/*           icon: CircleAvatar(
          foregroundImage: NetworkImage(UserPreferences.myUser.imagePath),
          // backgroundImage: NetworkImage(),
           backgroundColor: Colors.transparent,
          radius: screenHeightPercentage(context,percentage: 0.5),
        ),*/
          icon: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            // backgroundImage: NetworkImage(UserPreferences.myUser.imagePath),
            child: Image.network(
              // 'https://pbs.twimg.com/media/FHfttxDWQAAJQNK?format=jpg&name=large',
              UserPreferences.myUser.imagePath ?? placeholderSmall,
              // semanticLabel: 'Profile Picture',
              height: screenHeightPercentage(context, percentage: 0.1) /
                  screenWidthPercentage(context, percentage: 0.1) *
                  20,
              width: screenHeightPercentage(context, percentage: 0.1) /
                  screenWidthPercentage(context, percentage: 0.1) *
                  20,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) => loadingProgress == null
                  ? child
                  : CustomCircularIndicator(
                      color: Colors.black,
                      backgroundColor: Colors.transparent,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
