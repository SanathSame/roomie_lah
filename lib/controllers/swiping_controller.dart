import 'package:cloud_firestore/cloud_firestore.dart';

class SwipingController {
  static final _firestore = FirebaseFirestore.instance;
  CollectionReference _swipingCollection =
      FirebaseFirestore.instance.collection('swipes');

  getAllData() async {
    print(_firestore);
    QuerySnapshot querySnapshot = await _swipingCollection.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(allData);
    return;
  }

  checkNewUser(String currentUser) async {
    var doc = await _swipingCollection.doc(currentUser).get();
    return ((doc.exists));
  }

  createNewUser(String currentUser) async {
    await _swipingCollection.doc(currentUser).set({"left": [], "right": []});
  }

  updateSwipeData(
      String currentUser, String swipedUser, String swipeDirection) async {
    bool exists = await checkNewUser(currentUser);
    if (!exists) {
      createNewUser(currentUser);
    }
    await _swipingCollection.doc(currentUser).update({
      swipeDirection: FieldValue.arrayUnion([swipedUser])
    });
    return;
  }
}
