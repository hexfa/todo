import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/models/sync_model.dart';

class SyncLocalDataSource {
  final Box<SyncOperation> syncBox;

  SyncLocalDataSource(this.syncBox);

  Future<void> addOperation(SyncOperation operation) async {
    await syncBox.put(operation.id, operation);
  }

  Future<List<SyncOperation>> getOperations() async {
    return syncBox.values.toList();
  }

  Future<void> removeOperation(int index) async {
    await syncBox.deleteAt(index);
  }

  Future<void> clearQueue() async {
    await syncBox.clear();
  }
}
