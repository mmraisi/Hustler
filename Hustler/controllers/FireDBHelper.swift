//
//  FireDBHelper.swift
//  FirestoreDemo
//
//  Created by Tech on 2023-03-14.
//

import Foundation
import FirebaseFirestore

class FireDBHelper : ObservableObject{
    
//    @Published var bookList = [Book]()
    
    private let store : Firestore
    private static var shared : FireDBHelper?
    private let COLLECTION_PROD : String = "Books"
    
    
    let loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? ""
    
    init(store: Firestore) {
        self.store = store
    }
    
    static func getInstance() -> FireDBHelper?{
        if (shared == nil){
            shared = FireDBHelper(store: Firestore.firestore())
        }
        
        return shared
    }
    
//    func insertBook(newBook : Book){
//        print(#function, "Trying to insert book \(newBook.bTitle) to firestore")
//
//
//        if (loggedInUserEmail.isEmpty){
//            print(#function, "Logged in user not identified")
//        }else{
//
//            do{
//                try self.store
//                    .collection(COLLECTION_LIBRARY)
//                    .document(loggedInUserEmail)
//                    .collection(COLLECTION_BOOKS)
//                    .addDocument(from: newBook)
//            }catch let error as NSError{
//                print(#function, "Unable to add document to firestore : \(error)")
//            }
//        }
//    }
//
//    func getAllBooks(){
//
//        self.store
//            .collection(COLLECTION_LIBRARY)
//            .document(loggedInUserEmail)
//            .collection(COLLECTION_BOOKS)
////            .whereField("bIsFiction", isEqualTo: true) //to add any criteria
////            .order(by: "bTitle", descending: true)
//            .addSnapshotListener({ (querySnapshot, error) in
//
//                guard let snapshot = querySnapshot else{
//                    print(#function, "Unable to retrieve data from Firestore : \(error)")
//                    return
//                }
//
//                snapshot.documentChanges.forEach{ (docChange) in
//
//                    do{
//                        var book : Book = try docChange.document.data(as: Book.self)
//
//                        let docID = docChange.document.documentID
//                        book.id = docID
//
//                        let matchedIndex = self.bookList.firstIndex(where: { ($0.id?.elementsEqual(docID))! })
//
//                        if docChange.type == .added{
//                            self.bookList.append(book)
//                            print(#function, "Document added : \(book)")
//                        }
//
//                        if docChange.type == .removed{
//                            if (matchedIndex != nil){
//                                self.bookList.remove(at: matchedIndex!)
//                            }
//                        }
//
//                        if docChange.type == .modified{
//                            if (matchedIndex != nil){
//                                self.bookList[matchedIndex!] = book
//                            }
//                        }
//
//                    }catch let err as Error{
//                        print(#function, "Unable to convert the document into object : \(err)")
//                    }
//                }
//
//            })
//    }
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

