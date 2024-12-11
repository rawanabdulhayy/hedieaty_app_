import 'package:flutter/material.dart';
import 'package:hedieaty_app_mvc/core/config/theme/gradient_background.dart';
import '../../../../core/app_colors.dart';
import '../widgets/gift_card.dart';

class GiftListPage extends StatelessWidget {
  //TODO: This should be replaced with a provider to handle the context navigation and passing from one page to the other
  //final String eventName;

  //GiftListPage({required this.eventName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
        title: Center(
          child: Text(
            //TODO: event name's gift list using a provider? we need to send the context from the event from which we navigated to this gift list
            'Gift\'s List',
            style: TextStyle(
              color: AppColors.gold,
              fontFamily: "Pacifico",
            ),
          ),
        ),
        iconTheme: IconThemeData(
          color: AppColors.gold,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.card_giftcard),
            onPressed: () {
              // Action for the button goes here
            },
          ),
        ],
      ),
      body: GradientBackground(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              //TODO: Use the searchbar of ours
              child: TextField(
                //this needs to be functional
                decoration: InputDecoration(
                  filled: true, // Optional: if you want to fill the background
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.brightBlue,
                        width: 2.0), // Change enabled border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.gold,
                        width: 2.0), // Change focused border color
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.red,
                        width: 2.0), // Change error border color
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.redAccent,
                        width: 2.0), // Change focused error border color
                  ),
                  hintText: 'Search gifts...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(3.0),
              //TODO: Use the dropdownlist button of ours -- the customized
              child: DropdownButton<String>(
                items:
                    <String>['Status', 'Category', 'Name'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_) {}, //this needs to filter the data accordingly
                hint: Text('Sort by'),
                dropdownColor: Colors.white,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  //ToDo this too should  be a dynamic fetch from DB's gifts collection
                  //TODO: the gift card should follow a similar styling to the event card keeping its own gift unique features tho
                  GiftCard(
                      giftName: 'Watch',
                      status: 'Available',
                      category: 'Accessories'),
                  GiftCard(
                      giftName: 'Shoes',
                      status: 'Pledged',
                      category: 'Fashion'),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //TODO: in this current page we'll need to access the gift name, category, status of availability or pledged, event's name from which we navigated
          //TODO: While in gift details page, we will wanna access the name, description, category, price, status
          Navigator.pushNamed(context, '/gift_details');
          //TODO: This should be navigated to with no context for adding a new gift list
          //TODO: However the edit button in gift card should be navigated to with prefilling the gift details page with the current navigated from gift to only edit them and save edits
        },
        backgroundColor: AppColors.gold,
        child: Icon(Icons.add),
      ),
    );
  }
}
