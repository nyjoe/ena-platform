// roles/admin_calendar_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AdminCalendarPage extends StatefulWidget {
  const AdminCalendarPage({super.key});
  @override
  State<StatefulWidget> createState() => _AdminCalendarPageState();
}

class _AdminCalendarPageState extends State<AdminCalendarPage> {
  final _formKey = GlobalKey<FormState>();
  String? _titre, _description;
  DateTime? _selectedDate;

  Future<void> _addEvent() async {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      _formKey.currentState!.save();

      await FirebaseFirestore.instance.collection('calendrier').add({
        'titre': _titre,
        'description': _description,
        'date': DateFormat('yyyy-MM-dd').format(_selectedDate!),
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Événement ajouté au calendrier")),
      );

      _formKey.currentState!.reset();
      setState(() => _selectedDate = null);
    }
  }

  void _deleteEvent(String id) async {
    await FirebaseFirestore.instance.collection('calendrier').doc(id).delete();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Événement supprimé")),
    );
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final calendarStream = FirebaseFirestore.instance
        .collection('calendrier')
        .orderBy('date')
        .snapshots();

    return Scaffold(
      appBar: AppBar(title: Text("Gestion du calendrier")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Titre de l’événement'),
                  onSaved: (val) => _titre = val,
                  validator: (val) => val!.isEmpty ? 'Obligatoire' : null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  onSaved: (val) => _description = val,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _pickDate,
                      child: Text("📅 Choisir une date"),
                    ),
                    SizedBox(width: 10),
                    Text(_selectedDate == null
                        ? 'Aucune date'
                        : DateFormat('dd MMM yyyy').format(_selectedDate!)),
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _addEvent,
                  child: Text("➕ Ajouter l’événement"),
                ),
              ]),
            ),
            Divider(height: 30),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: calendarStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();

                  final events = snapshot.data!.docs;

                  if (events.isEmpty) return Text("Aucun événement programmé.");

                  return ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final event = events[index].data() as Map<String, dynamic>;
                      final docId = events[index].id;

                      return ListTile(
                        leading: Icon(Icons.event),
                        title: Text(event['titre']),
                        subtitle: Text("${event['description'] ?? ''}\n📆 ${event['date']}"),
                        isThreeLine: true,
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteEvent(docId),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
