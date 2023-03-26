//
//  FireDBHelper.swift
//  FirestoreDemo
//
//  Created by Tech on 2023-03-14.
//

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
//
    func getAllPendingOrder(){
        self.store
            .collection(COLLECTION_ORDER)
            .whereField("isAccepted", isEqualTo: false)
            .whereField("customer.cEmail", isEqualTo: loggedInUserEmail)
            .addSnapshotListener({ (querySnapshot, error) in
                guard let snapshot = querySnapshot else{
                    print(#function, "Unable to retrieve data from Firestore : \(error)")
                    return
                }

                snapshot.documentChanges.forEach{ (docChange) in

                    do{
                        var order : Order = try docChange.document.data(as: Order.self)

                        let docID = docChange.document.documentID
                        order.id = docID

                        let matchedIndex = self.pendingList.firstIndex(where: { ($0.id?.elementsEqual(docID))! })

                        if docChange.type == .added{
                            self.pendingList.append(order)
                            print(#function, "Document added : \(order)")
                        }

                        if docChange.type == .removed{
                            if (matchedIndex != nil){
                                self.pendingList.remove(at: matchedIndex!)
                            }
                        }

                        if docChange.type == .modified{
                            if (matchedIndex != nil){
                                self.pendingList[matchedIndex!] = order
                            }
                        }

                    }catch let err as Error{
                        print(#function, "Unable to convert the document into object : \(err)")
                    }
                }

            })
    }
    func getAllCompletedOrder(){
        self.store
            .collection(COLLECTION_ORDER)
            .whereField("isAccepted", isEqualTo: true)
            .whereField("customer.cEmail", isEqualTo: loggedInUserEmail)
            .addSnapshotListener({ (querySnapshot, error) in
                guard let snapshot = querySnapshot else{
                    print(#function, "Unable to retrieve data from Firestore : \(error)")
                    return
                }

                snapshot.documentChanges.forEach{ (docChange) in

                    do{
                        var order : Order = try docChange.document.data(as: Order.self)

                        let docID = docChange.document.documentID
                        order.id = docID

                        let matchedIndex = self.completedList.firstIndex(where: { ($0.id?.elementsEqual(docID))! })

                        if docChange.type == .added{
                            self.completedList.append(order)
                            print(#function, "Document added : \(order)")
                        }

                        if docChange.type == .removed{
                            if (matchedIndex != nil){
                                self.completedList.remove(at: matchedIndex!)
                            }
                        }

                        if docChange.type == .modified{
                            if (matchedIndex != nil){
                                self.completedList[matchedIndex!] = order
                            }
                        }

                    }catch let err as Error{
                        print(#function, "Unable to convert the document into object : \(err)")
                    }
                }

            })
    }
    func getAllCanceledOrder(){
        self.store
            .collection(COLLECTION_ORDER)
            .whereField("isCanceled", isEqualTo: true)
            .whereField("customer.cEmail", isEqualTo: loggedInUserEmail)
            .addSnapshotListener({ (querySnapshot, error) in
                guard let snapshot = querySnapshot else{
                    print(#function, "Unable to retrieve data from Firestore : \(error)")
                    return
                }

                snapshot.documentChanges.forEach{ (docChange) in

                    do{
                        var order : Order = try docChange.document.data(as: Order.self)

                        let docID = docChange.document.documentID
                        order.id = docID

                        let matchedIndex = self.canceledList.firstIndex(where: { ($0.id?.elementsEqual(docID))! })

                        if docChange.type == .added{
                            self.canceledList.append(order)
                            print(#function, "Document added : \(order)")
                        }

                        if docChange.type == .removed{
                            if (matchedIndex != nil){
                                self.canceledList.remove(at: matchedIndex!)
                            }
                        }

                        if docChange.type == .modified{
                            if (matchedIndex != nil){
                                self.canceledList[matchedIndex!] = order
                            }
                        }

                    }catch let err as Error{
                        print(#function, "Unable to convert the document into object : \(err)")
                    }
                }

            })
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
//    func updateBook(bookToUpdate : Book){
//        self.store
//            .collection(COLLECTION_LIBRARY)
//            .document(loggedInUserEmail)
//            .collection(COLLECTION_BOOKS)
//            .document(bookToUpdate.id!)
//            .updateData([FIELD_TITLE : bookToUpdate.bTitle,
//                        FIELD_AUTHOR : bookToUpdate.bAuthor,
//                       FIELD_FICTION : bookToUpdate.bIsFiction]){error in
//
//                if let error = error {
//                    print(#function, "Unable to update document : \(error)")
//                }else{
//                    print(#function, "Successfully updated \(bookToUpdate.bTitle) book in the firestore")
//                }
//            }
//    }
    
}

