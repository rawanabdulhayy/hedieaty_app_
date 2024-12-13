import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // For dependency injection
import '../../../../core/app_colors.dart';
import '../../../../core/config/theme/gradient_background.dart';
import '../../../../core/presentation/widgets/dropdown_list/custom_dropdown_button.dart';
import '../../../../core/presentation/widgets/text_fields/text_form_field.dart';
import '../../domain/entity/Gift.dart';
import '../../domain/repositories/domain_gift_repo.dart';

class GiftDetailsPage extends StatefulWidget {
  final String eventId;
  final String eventName;
  final Gift? gift;

  const GiftDetailsPage({
    Key? key,
    required this.eventId,
    required this.eventName,
    this.gift,
  }) : super(key: key);

  @override
  State<GiftDetailsPage> createState() => _GiftDetailsPageState();
}

class _GiftDetailsPageState extends State<GiftDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  bool _isAvailable = true;

  late GiftDomainRepository giftDomainRepository;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    giftDomainRepository = Provider.of<GiftDomainRepository>(context, listen: false);
  }

  @override
  void initState() {
    super.initState();
    if (widget.gift != null) {
      _nameController.text = widget.gift!.name;
      _descriptionController.text = widget.gift!.description;
      _categoryController.text = widget.gift!.category;
      _priceController.text = widget.gift!.price.toString();
      _isAvailable = widget.gift!.status == 'Available';
    }
  }

  Future<void> _saveGift() async {
    if (!_formKey.currentState!.validate()) return;

    if (giftDomainRepository == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gift repository is not initialized')),
      );
      return;
    }

    final gift = Gift(
      id: widget.gift?.id ?? '',
      name: _nameController.text,
      description: _descriptionController.text,
      category: _categoryController.text,
      price: double.tryParse(_priceController.text) ?? 0.0,
      status: _isAvailable ? 'Available' : 'Pledged',
      eventId: widget.eventId,
      isPledged: false,
    );

    try {
      await giftDomainRepository.upsertGift(gift);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(widget.gift == null ? 'Gift added!' : 'Gift updated!')),
      );
      Navigator.of(context).pop();
    } catch (e) {
      print('Failed to save gift: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
        title: Center(
          child: Text(
            widget.gift == null ? 'Add Gift' : 'Edit Gift',
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
                  validator: (value) => value == null || value.isEmpty ? 'Enter a gift name' : null,
                ),
                CustomTextFormField(
                  controller: _descriptionController,
                  labelText: 'Description',
                  hintText: 'Enter gift description',
                ),
                CustomDropdownButton(
                  hint: Text(
                    'Select Category',
                    style: TextStyle(color: AppColors.gold.withOpacity(0.6)),
                  ),
                  items: const ['Electronics', 'Books', 'Clothing', 'Toys'],
                  value: _categoryController.text.isEmpty ? null : _categoryController.text,
                  onChanged: (value) => setState(() {
                    _categoryController.text = value ?? '';
                  }),
                  iconColor: AppColors.gold,
                  dropdownColor: Colors.white,
                  selectedTextStyle: const TextStyle(color: AppColors.gold),
                ),
                CustomTextFormField(
                  controller: _priceController,
                  labelText: 'Price',
                  hintText: 'Enter price',
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter a price';
                    if (int.tryParse(value) == null) return 'Enter a valid number';
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),
                SwitchListTile(
                  title: const Text('Available'),
                  value: _isAvailable,
                  onChanged: (value) {
                    setState(() {
                      //Todo: this should be a readonly defaulted to available
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
                      widget.gift == null ? 'Add Gift' : 'Update Gift',
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
