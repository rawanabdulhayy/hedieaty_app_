// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../../core/app_colors.dart';
// import '../../../../core/config/theme/gradient_background.dart';
// import '../../../../core/presentation/widgets/dropdown_list/custom_dropdown_button.dart';
// import '../../../../core/presentation/widgets/text_fields/text_form_field.dart';
// import '../../domain/entity/Gift.dart';
// import '../../domain/repositories/domain_gift_repo.dart';
//
// class GiftDetailsPage extends StatefulWidget {
//   final String eventId;
//   final String eventName;
//
//   const GiftDetailsPage({
//     Key? key,
//     required this.eventId,
//     required this.eventName,
//     required giftId,
//     required giftName,
//     required giftDescription,
//     required giftCategory,
//     required giftPrice,
//     required giftStatus,
//   }) : super(key: key);
//
//   @override
//   State<GiftDetailsPage> createState() => _GiftDetailsPageState();
// }
//
// class _GiftDetailsPageState extends State<GiftDetailsPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _categoryController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();
//   bool _isAvailable = true;
//   String _giftId = '';
//
//   late GiftDomainRepository giftDomainRepository;
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//
//     // Initialize repository
//     giftDomainRepository =
//         Provider.of<GiftDomainRepository>(context, listen: false);
//
//     // Fetch arguments if provided
//     final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
//     if (args != null) {
//       print("args");
//       _giftId = args['giftId'] ?? '';
//       _nameController.text = args['giftName'] ?? '';
//       _descriptionController.text = args['giftDescription'] ?? '';
//       _categoryController.text = args['giftCategory'] ?? '';
//       _priceController.text = args['giftPrice'] ?? '';
//       _isAvailable = (args['giftStatus'] ?? 'Available') == 'Available';
//     } else if (widget.gift != null) {
//       print("widget");
//       _giftId = widget.gift!.id;
//       _nameController.text = widget.gift!.name;
//       _descriptionController.text = widget.gift!.description;
//       _categoryController.text = widget.gift!.category;
//       _priceController.text = widget.gift!.price.toString();
//       _isAvailable = widget.gift!.status == 'Available';
//     }
//   }
//
//   Future<void> _saveGift() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     final gift = Gift(
//       id: _giftId.isNotEmpty ? _giftId : '',
//       name: _nameController.text,
//       description: _descriptionController.text,
//       category: _categoryController.text,
//       price: double.tryParse(_priceController.text) ?? 0.0,
//       status: _isAvailable ? 'Available' : 'Pledged',
//       eventId: widget.eventId,
//       isPledged: !_isAvailable,
//       pledgedBy: _isAvailable ? "Nobody yet" : "Friend's Name",
//     );
//
//     try {
//       await giftDomainRepository.upsertGift(gift);
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(widget.gift == null ? 'Gift added successfully!' : 'Gift updated successfully!'),
//         ),
//       );
//       Navigator.of(context).pop();
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to save gift: $e')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.navyBlue,
//         title: Center(
//           child: Text(
//             widget.gift == null ? 'Add Gift' : 'Edit Gift',
//             style: const TextStyle(color: AppColors.gold, fontFamily: "Pacifico"),
//           ),
//         ),
//       ),
//       body: GradientBackground(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CustomTextFormField(
//                   controller: _nameController,
//                   labelText: 'Gift Name',
//                   hintText: 'Enter gift name',
//                   validator: (value) =>
//                   value == null || value.isEmpty ? 'Enter a gift name' : null,
//                 ),
//                 CustomTextFormField(
//                   controller: _descriptionController,
//                   labelText: 'Description',
//                   hintText: 'Enter gift description',
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 125.0),
//                   child: CustomDropdownButton(
//                     hint: const Text(
//                       'Select Category',
//                       style: TextStyle(color: AppColors.lightAmber),
//                     ),
//                     items: const ['Electronics', 'Books', 'Clothing', 'Toys'],
//                     value: _categoryController.text.isEmpty
//                         ? null
//                         : _categoryController.text,
//                     onChanged: (value) {
//                       setState(() {
//                         _categoryController.text = value ?? '';
//                       });
//                     },
//                     iconColor: AppColors.gold,
//                     dropdownColor: Colors.white,
//                     selectedTextStyle:
//                     const TextStyle(color: AppColors.lightAmber),
//                   ),
//                 ),
//                 CustomTextFormField(
//                   controller: _priceController,
//                   labelText: 'Price',
//                   hintText: 'Enter price',
//                   validator: (value) {
//                     if (value == null || value.isEmpty) return 'Enter a price';
//                     if (double.tryParse(value) == null)
//                       return 'Enter a valid number';
//                     return null;
//                   },
//                   keyboardType: TextInputType.number,
//                 ),
//                 SwitchListTile(
//                   title: const Text('Available'),
//                   value: _isAvailable,
//                   onChanged: (value) {
//                     setState(() {
//                       _isAvailable = value;
//                     });
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: _saveGift,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.gold,
//                       foregroundColor: AppColors.navyBlue,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.0),
//                       ),
//                     ),
//                     child: Text(
//                       widget.gift == null ? 'Add Gift' : 'Update Gift',
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/config/theme/gradient_background.dart';
import '../../../../core/presentation/widgets/dropdown_list/custom_dropdown_button.dart';
import '../../../../core/presentation/widgets/text_fields/text_form_field.dart';
import '../../domain/entity/Gift.dart';
import '../../domain/repositories/domain_gift_repo.dart';

class GiftDetailsPage extends StatefulWidget {
  final String eventId;
  final String eventName;
  final String giftId;
  final String giftName;
  final String giftDescription;
  final String giftCategory;
  final double giftPrice;
  final String giftStatus;

  const GiftDetailsPage({
    Key? key,
    required this.eventId,
    required this.eventName,
    required this.giftId,
    required this.giftName,
    required this.giftDescription,
    required this.giftCategory,
    required this.giftPrice,
    required this.giftStatus,
  }) : super(key: key);

  @override
  State<GiftDetailsPage> createState() => _GiftDetailsPageState();
}

class _GiftDetailsPageState extends State<GiftDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  // Status Field
  bool _isAvailable = true;
  late GiftDomainRepository giftDomainRepository;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with data passed via constructor
    _nameController.text = widget.giftName;
    _descriptionController.text = widget.giftDescription;
    _categoryController.text = widget.giftCategory;
    _priceController.text = widget.giftPrice.toString();
    _isAvailable = widget.giftStatus == 'Available';
  }

  Future<void> _saveGift() async {
    if (!_formKey.currentState!.validate()) return;

    final gift = Gift(
      id: widget.giftId.isNotEmpty ? widget.giftId : '',
      name: _nameController.text,
      description: _descriptionController.text,
      category: _categoryController.text,
      price: double.tryParse(_priceController.text) ?? 0.0,
      status: _isAvailable ? 'Available' : 'Pledged',
      eventId: widget.eventId,
      isPledged: !_isAvailable,
      pledgedBy: _isAvailable ? "Nobody yet" : "Friend's Name",
    );

    try {
      await giftDomainRepository.upsertGift(gift);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.giftId.isEmpty
              ? 'Gift added successfully!'
              : 'Gift updated successfully!'),
        ),
      );
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save gift: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    giftDomainRepository =
        Provider.of<GiftDomainRepository>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
        title: Center(
          child: Text(
            widget.giftId.isEmpty ? 'Add Gift' : 'Edit Gift',
            style: const TextStyle(color: AppColors.gold, fontFamily: "Pacifico"),
          ),
        ),
      ),
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  controller: _nameController,
                  labelText: 'Gift Name',
                  hintText: 'Enter gift name',
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Enter a gift name' : null,
                ),
                CustomTextFormField(
                  controller: _descriptionController,
                  labelText: 'Description',
                  hintText: 'Enter gift description',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 125.0),
                  child: CustomDropdownButton(
                    hint: const Text(
                      'Select Category',
                      style: TextStyle(color: AppColors.lightAmber),
                    ),
                    items: const ['Electronics', 'Books', 'Clothing', 'Toys'],
                    value: _categoryController.text.isEmpty
                        ? null
                        : _categoryController.text, // Set value directly from the controller
                    onChanged: (value) {
                      setState(() {
                        _categoryController.text = value ?? '';
                      });
                    },
                    iconColor: AppColors.gold,
                    dropdownColor: Colors.white,
                    selectedTextStyle: const TextStyle(color: AppColors.lightAmber),
                  ),
                ),
                CustomTextFormField(
                  controller: _priceController,
                  labelText: 'Price',
                  hintText: 'Enter price',
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter a price';
                    if (double.tryParse(value) == null) {
                      return 'Enter a valid number';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),
                SwitchListTile(
                  title: const Text('Available'),
                  value: _isAvailable,
                  onChanged: (value) {
                    setState(() {
                      _isAvailable = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _saveGift,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.gold,
                      foregroundColor: AppColors.navyBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: Text(
                      widget.giftId.isEmpty ? 'Add Gift' : 'Update Gift',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

