import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ChildProfile {
  ChildProfile({
    required this.id,
    required this.name,
    required this.dob,
    required this.gender,
    required this.guardianName,
    required this.contactNumber,
    this.notes = '',
  });

  final String id;
  final String name;
  final DateTime dob;
  final String gender;
  final String guardianName;
  final String contactNumber;
  final String notes;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dob': Timestamp.fromDate(dob),
      'gender': gender,
      'guardianName': guardianName,
      'contactNumber': contactNumber,
      'notes': notes,
    };
  }

  ChildProfile copyWith({
    String? id,
    String? name,
    DateTime? dob,
    String? gender,
    String? guardianName,
    String? contactNumber,
    String? notes,
  }) {
    return ChildProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      guardianName: guardianName ?? this.guardianName,
      contactNumber: contactNumber ?? this.contactNumber,
      notes: notes ?? this.notes,
    );
  }

  static ChildProfile fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    final Timestamp? dobTimestamp = data['dob'] as Timestamp?;
    return ChildProfile(
      id: doc.id,
      name: data['name'] as String? ?? 'Unknown',
      dob: dobTimestamp?.toDate() ?? DateTime.now(),
      gender: data['gender'] as String? ?? 'Unknown',
      guardianName: data['guardianName'] as String? ?? '',
      contactNumber: data['contactNumber'] as String? ?? '',
      notes: data['notes'] as String? ?? '',
    );
  }
}

class GrowthRecord {
  GrowthRecord({
    required this.id,
    required this.date,
    required this.ageInMonths,
    required this.weight,
    required this.height,
    required this.muac,
    this.notes = '',
  });

  final String id;
  final DateTime date;
  final double ageInMonths;
  final double weight;
  final double height;
  final double muac;
  final String notes;

  Map<String, dynamic> toMap() {
    return {
      'date': Timestamp.fromDate(date),
      'ageInMonths': ageInMonths,
      'weight': weight,
      'height': height,
      'muac': muac,
      'notes': notes,
    };
  }

  GrowthRecord copyWith({
    String? id,
    DateTime? date,
    double? ageInMonths,
    double? weight,
    double? height,
    double? muac,
    String? notes,
  }) {
    return GrowthRecord(
      id: id ?? this.id,
      date: date ?? this.date,
      ageInMonths: ageInMonths ?? this.ageInMonths,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      muac: muac ?? this.muac,
      notes: notes ?? this.notes,
    );
  }

  static GrowthRecord fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    final Timestamp? dateTimestamp = data['date'] as Timestamp?;
    return GrowthRecord(
      id: doc.id,
      date: dateTimestamp?.toDate() ?? DateTime.now(),
      ageInMonths: (data['ageInMonths'] as num?)?.toDouble() ?? 0,
      weight: (data['weight'] as num?)?.toDouble() ?? 0,
      height: (data['height'] as num?)?.toDouble() ?? 0,
      muac: (data['muac'] as num?)?.toDouble() ?? 0,
      notes: data['notes'] as String? ?? '',
    );
  }
}

class ChildrenProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<ChildProfile> _children = [];
  final Map<String, List<GrowthRecord>> _growthRecords = {};
  bool _isLoading = false;
  String? _error;

  List<ChildProfile> get children => _children;
  Map<String, List<GrowthRecord>> get growthRecords => _growthRecords;
  bool get isLoading => _isLoading;
  String? get error => _error;

  ChildProfile? getChildById(String? id) {
    if (id == null) return null;
    try {
      return _children.firstWhere((child) => child.id == id);
    } catch (_) {
      return null;
    }
  }

  List<GrowthRecord> getGrowthForChild(String childId) {
    return _growthRecords[childId] ?? [];
  }

  Future<void> loadChildren() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final snapshot = await _firestore
          .collection('children')
          .orderBy('name')
          .get();
      _children = snapshot.docs.map(ChildProfile.fromDoc).toList();
    } catch (e) {
      print('Unable to load children: $e');
      _error = 'Unable to load children: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addOrUpdateChild(ChildProfile child) async {
    _error = null;
    notifyListeners();
    try {
      if (child.id.isEmpty) {
        final doc = await _firestore.collection('children').add(child.toMap());
        _children = [..._children, child.copyWith(id: doc.id)];
      } else {
        await _firestore
            .collection('children')
            .doc(child.id)
            .set(child.toMap(), SetOptions(merge: true));
        _children = _children
            .map((c) => c.id == child.id ? child : c)
            .toList(growable: false);
      }
      notifyListeners();
    } catch (e) {
      print('Unable to save child: $e');
      _error = 'Unable to save child: $e';
      notifyListeners();
      rethrow;
    }
  }

  Future<void> deleteChild(String childId) async {
    _error = null;
    notifyListeners();
    try {
      await _firestore.collection('children').doc(childId).delete();
      _children = _children.where((c) => c.id != childId).toList();
      _growthRecords.remove(childId);
      notifyListeners();
    } catch (e) {
      print('Unable to delete child: $e');
      _error = 'Unable to delete child: $e';
      notifyListeners();
      rethrow;
    }
  }

  Future<void> loadGrowthRecords(String childId) async {
    try {
      final snapshot = await _firestore
          .collection('children')
          .doc(childId)
          .collection('growthRecords')
          .orderBy('date', descending: true)
          .get();
      _growthRecords[childId] = snapshot.docs
          .map(GrowthRecord.fromDoc)
          .toList(growable: false);
      notifyListeners();
    } catch (e) {
      print('Unable to load growth records: $e');
      _error = 'Unable to load growth records: $e';
      notifyListeners();
    }
  }

  Future<void> addGrowthRecord(String childId, GrowthRecord record) async {
    _error = null;
    notifyListeners();
    try {
      final doc = await _firestore
          .collection('children')
          .doc(childId)
          .collection('growthRecords')
          .add(record.toMap());
      final updatedRecord = record.copyWith(id: doc.id);
      final List<GrowthRecord> records = [
        ...(_growthRecords[childId] ?? []),
        updatedRecord,
      ];
      _growthRecords[childId] = records;
      notifyListeners();
    } catch (e) {
      print('Unable to save growth record: $e');
      _error = 'Unable to save growth record: $e';
      notifyListeners();
      rethrow;
    }
  }
}
