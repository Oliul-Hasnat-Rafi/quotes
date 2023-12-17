import 'package:hive/hive.dart';
part 'model_hive.g.dart';

@HiveType(typeId: 0)
class model_hive {
  model_hive({ this.quotes,  this.authorname});
  @HiveField(0)
  final String ?quotes;
  @HiveField(1)
  final String? authorname;
@override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}
