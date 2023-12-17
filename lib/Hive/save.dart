import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:quotes/Hive/model_hive.dart';

class Save extends StatefulWidget {
  const Save({super.key});

  @override
  State<Save> createState() => _SaveState();
}

class _SaveState extends State<Save> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ValueListenableBuilder(
        valueListenable: Hive.box<model_hive>('Favt').listenable(),
        builder: (context, Box<model_hive> box, _) {
          if (box.values.isEmpty) {
            return Center(
              child: Text('No Favt Quotes available'),
            );
          } else {
            return ListView.separated(
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                var result = box.getAt(index);
                return Card(
                  child: ListTile(
                    title: Text(result!.quotes!),
                    subtitle: Text(result.authorname!),
                    trailing: InkWell(
                      child: const Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      ),
                      onTap: () {
                        box.deleteAt(index);
                      },
                    ),
                  ),
                );
              },
              separatorBuilder: (context, i) {
                return const SizedBox(height: 12);
              },
            );
          }
        },
      ),
    );
  }
}
