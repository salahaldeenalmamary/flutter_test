import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:webapp/stc/util/image.dart';
import '../../../models/delivery_details.dart';
import '../../../theme/app_styles.dart';

enum EditType { none, address, note }

class DeliveryAddressSection extends HookWidget {
  final DeliveryDetails initialDetails;
  final ValueChanged<DeliveryDetails>? onSave;

  const DeliveryAddressSection({
    super.key,
    required this.initialDetails,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final editType = useState(EditType.none);

    final streetController =
        useTextEditingController(text: initialDetails.street);
    final detailsController =
        useTextEditingController(text: initialDetails.details);
    final noteController = useTextEditingController(text: initialDetails.note);

    useEffect(() {
      streetController.text = initialDetails.street;
      detailsController.text = initialDetails.details;
      noteController.text = initialDetails.note ?? '';
      editType.value = EditType.none;
      return null;
    }, [initialDetails]);

    Widget _buildActionButton(
        String label,   String name, VoidCallback? onPressed) {
      return OutlinedButton.icon(
        onPressed: onPressed,
        icon:Image.asset(name),
        label: Text(label,
            style: FontTheme.subtitle.copyWith(color: ColorTheme.textPrimary)),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          side: const BorderSide(color: ColorTheme.grey),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      );
    }

    Widget _customTextField({
      required TextEditingController controller,
      required String label,
      int maxLines = 1,
    }) {
      return TextField(
        controller: controller,
        maxLines: maxLines,
        style: FontTheme.body,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: FontTheme.subtitle,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: ColorTheme.grey)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: ColorTheme.grey)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: ColorTheme.primary)),
        ),
      );
    }

    Widget displayMode() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Delivery Address', style: FontTheme.title),
          Gap.h8,
          Text(initialDetails.street,
              style: FontTheme.body.copyWith(fontWeight: FontWeight.w600)),
          Gap.h4,
          Text(initialDetails.details, style: FontTheme.subtitle),
          if (initialDetails.note != null &&
              initialDetails.note!.isNotEmpty) ...[
            Gap.h8,
            Text('Note:',
                style: FontTheme.body
                    .copyWith(fontWeight: FontTheme.body.fontWeight)),
            Gap.h4,
            Text(initialDetails.note!, style: FontTheme.subtitle),
          ],
          Gap.h12,
          Row(
            children: [
              _buildActionButton('Edit Address', ImageConstants.Edit, () {
                editType.value = EditType.address;
              }),
              Gap.w12,
              _buildActionButton(
                initialDetails.note?.isNotEmpty == true
                    ? 'Edit Note'
                    : 'Add Note',
                ImageConstants.Note,
                () => editType.value = EditType.note,
              ),
            ],
          ),
        ],
      );
    }

    Widget editingAddressFields() {
      return Column(
        children: [
          _customTextField(controller: streetController, label: 'Street'),
          Gap.h12,
          _customTextField(
              controller: detailsController, label: 'Details', maxLines: 2),
        ],
      );
    }

    Widget editingNoteField() {
      return _customTextField(
          controller: noteController, label: 'Note (Optional)', maxLines: 3);
    }

    Widget editingMode() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Edit Delivery Address', style: FontTheme.title),
          Gap.h12,
          if (editType.value == EditType.address) editingAddressFields(),
          if (editType.value == EditType.note) editingNoteField(),
          Gap.h24,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () {
                  streetController.text = initialDetails.street;
                  detailsController.text = initialDetails.details;
                  noteController.text = initialDetails.note ?? '';
                  editType.value = EditType.none;
                },
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  side: const BorderSide(color: ColorTheme.grey),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Text('Cancel',
                    style:
                        FontTheme.body.copyWith(color: ColorTheme.textPrimary)),
              ),
              Gap.w12,
              ElevatedButton(
                onPressed: () {
                  final updatedDetails = DeliveryDetails(
                    street: streetController.text,
                    details: detailsController.text,
                    note: noteController.text.isNotEmpty
                        ? noteController.text
                        : null,
                  );
                  onSave?.call(updatedDetails);
                  editType.value = EditType.none;
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorTheme.primary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Text('Save',
                    style:
                        FontTheme.body.copyWith(color: ColorTheme.textLight)),
              ),
            ],
          ),
        ],
      );
    }

    return Padding(
      padding: AppPaddings.horizontalScreen,
      child: editType.value == EditType.none ? displayMode() : editingMode(),
    );
  }
}
