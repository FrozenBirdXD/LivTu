import 'package:flutter/material.dart';
import 'package:livtu/utils/conversions/event_model_conversions.dart';
import 'package:livtu/views/schedule/event_model.dart';
import 'package:livtu/views/schedule/provider/event_provider.dart';
import 'package:provider/provider.dart';

class EditEventView extends StatefulWidget {
  final Event? event;

  const EditEventView({
    Key? key,
    this.event,
  }) : super(key: key);

  @override
  State<EditEventView> createState() => _EditEventViewState();
}

class _EditEventViewState extends State<EditEventView> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;

  @override
  void initState() {
    super.initState();
    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(
        const Duration(hours: 1),
      );
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Event'),
          centerTitle: true,
          actions: [
            ElevatedButton.icon(
              onPressed: saveForm,
              icon: const Icon(Icons.done),
              label: const Text('Save'),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 36.0,
              vertical: 48.0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  titleField(),
                  const SizedBox(
                    height: 36.0,
                  ),
                  buildDateTimePickers(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future saveForm() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final event = Event(
        title: titleController.text,
        from: fromDate,
        to: toDate,
        description: 'Description',
        color: Colors.pink,
        isAllDay: false,
      );

      final provider = Provider.of<EventProvider>(context, listen: false);
      provider.addEvent(event);

      Navigator.of(context).pop();
    }
  }

  Widget titleField() {
    return TextFormField(
      style: const TextStyle(fontSize: 24),
      controller: titleController,
      onFieldSubmitted: (_) => saveForm(),
      validator: (title) =>
          title != null && title.isEmpty ? 'Title cannot be empty' : null,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[250],
        labelText: 'Title',
        labelStyle: const TextStyle(fontSize: 24.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: Colors.grey[300]!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: Colors.teal,
          ),
        ),
      ),
    );
  }

  Widget buildDateTimePickers() {
    return Column(
      children: [
        buildFrom(),
        buildTo(),
      ],
    );
  }

  Widget buildTo() {
    return buildHeader(
      header: 'TO',
      child: Row(
        children: [
          Expanded(
            child: buildDropdownField(
              text: Conversions.toDate(toDate),
              onClicked: () => pickToDateTime(pickDate: true),
            ),
          ),
          Expanded(
            child: buildDropdownField(
              text: Conversions.toTime(toDate),
              onClicked: () => pickToDateTime(pickDate: false),
            ),
          )
        ],
      ),
    );
  }

  Widget buildFrom() {
    return buildHeader(
      header: 'FROM',
      child: Row(
        children: [
          Expanded(
            child: buildDropdownField(
              text: Conversions.toDate(fromDate),
              onClicked: () => pickFromDateTime(pickDate: true),
            ),
          ),
          Expanded(
            child: buildDropdownField(
              text: Conversions.toTime(fromDate),
              onClicked: () => pickFromDateTime(pickDate: false),
            ),
          )
        ],
      ),
    );
  }

  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(
      toDate,
      pickDate: pickDate,
      firstDate: pickDate ? fromDate : null,
    );
    if (date == null) return;

    setState(() => toDate = date);
  }

  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(
      fromDate,
      pickDate: pickDate,
    );
    if (date == null) return;

    if (date.isAfter(toDate)) {
      toDate = DateTime(
        date.year,
        date.month,
        date.day,
        toDate.hour,
        toDate.minute,
      );
    }

    setState(() => fromDate = date);
  }

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2015, 8),
        lastDate: DateTime(2100),
      );

      if (date == null) return null;

      final time = Duration(
        hours: initialDate.hour,
        minutes: initialDate.minute,
      );

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );

      if (timeOfDay == null) return null;

      final date = DateTime(
        initialDate.year,
        initialDate.month,
        initialDate.day,
      );
      final time = Duration(
        hours: timeOfDay.hour,
        minutes: timeOfDay.minute,
      );

      return date.add(time);
    }
  }

  Widget buildDropdownField({
    required String text,
    required VoidCallback onClicked,
  }) {
    return ListTile(
      title: Text(text),
      trailing: const Icon(Icons.arrow_drop_down),
      onTap: onClicked,
    );
  }

  Widget buildHeader({
    required String header,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        child,
      ],
    );
  }
}
