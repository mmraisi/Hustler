//
//  FireDBHelper.swift

import Foundation
import FirebaseFirestore
import Firebase

class FireDBHelper : ObservableObject{
    
//    @Published var bookList = [Book]()
    @Published var pendingList = [Order]()
    @Published var completedList = [Order]()
    @Published var canceledList = [Order]()
    private let store : Firestore
    private static var shared : FireDBHelper?
    private let COLLECTION_ORDER : String = "Order"
    private let FIELD_IS_ACCEPTED : String = "isAccepted"
    private let FIELD_IS_CANCELED : String = "isCanceled"
    var dataSource = DataSoruce()
    
    
    
    let loggedInUserEmail = Auth.auth().currentUser?.email ?? ""
    
    init(store: Firestore) {
        self.store = store
    }
    
    static func getInstance() -> FireDBHelper?{
        if (shared == nil){
            shared = FireDBHelper(store: Firestore.firestore())
        }
        
        return shared
    }
    
    func insertOrder(order : Order){
        if (loggedInUserEmail.isEmpty){
            print(#function, "Logged in user not identified")
        }else{

            do{
                try self.store
                    .collection(COLLECTION_ORDER)
                    .addDocument(from: order)
            }catch let error as NSError{
                print(#function, "Unable to add document to firestore : \(error)")
            }
        }
    }
    
    
    func getAllOrders(completion: @escaping ([Order]?, Error?) -> Void) -> ListenerRegistration? {
        let listener = self.store.collection(COLLECTION_ORDER).addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print(#function, "Unable to retrieve data from Firestore : \(error)")
                completion(nil, error)
                return
            }
            
            var orders: [Order] = []
            
            querySnapshot?.documents.forEach { document in
                do {
                    var order: Order = try document.data(as: Order.self)
                    order.id = document.documentID
                    
                    orders.append(order)
                } catch let error {
                    print(#function, "Unable to convert the document into object : \(error)")
                }
            }
            print("orders: \(orders.count)")
            completion(orders, nil)
        }
        
        return listener
    }

    func updateOrder(orderToUpdate: Order, completion: @escaping (Error?) -> Void) {
        self.store
            .collection(COLLECTION_ORDER)
            .document(orderToUpdate.id!)
            .updateData([
                FIELD_IS_ACCEPTED : orderToUpdate.isAccepted,
                FIELD_IS_CANCELED : orderToUpdate.isCanceled
            ]) { error in
                if let error = error {
                    print(#function, "Unable to update document : \(error)")
                } else {
                    print(#function, "Successfully updated \(orderToUpdate.customer.cName)'s order in the firestore")
                }
                completion(error)
            }
    }
    func reset(){
        self.pendingList = [Order]()
        self.completedList = [Order]()
        self.canceledList = [Order]()
    }
    
    //
    //    func deleteBook(bookToDelete : Book){
    //
    //        self.store
    //            .collection(COLLECTION_LIBRARY)
    //            .document(loggedInUserEmail)
    //            .collection(COLLECTION_BOOKS)
    //            .document(bookToDelete.id!)
    //            .delete{error in
    //
    //                if let error = error {
    //                    print(#function, "Unable to delete document : \(error)")
    //                }else{
    //                    print(#function, "Successfully deleted \(bookToDelete.bTitle) book from the firestore")
    //                }
    //
    //            }
    //    }
    //
}

