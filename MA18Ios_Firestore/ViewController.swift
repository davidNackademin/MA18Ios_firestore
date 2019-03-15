//
//  ViewController.swift
//  MA18Ios_Firestore
//
//  Created by David Svensson on 2019-03-15.
//  Copyright © 2019 David Svensson. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var db: Firestore!
    var items =  [Item]()
    let cellId = "cellid"
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        if let label = cell.textLabel {
            label.text = items[indexPath.row].name
        }
        
        return cell
    }
    

   
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        let item = Item(name: "äpple")
        db.collection("items").addDocument(data: item.toAny())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        db = Firestore.firestore()
        
        //let ost = ["name" : "ost", "done" : false ] as [String : Any]
        
        //db.collection("items").document("ost").setData(ost)
       // db.collection("items").addDocument(data: ost)
        
//        let majs = Item(name: "Majs")
//
//        db.collection("items").addDocument(data: majs.toAny())
        
        let itemsRef = db.collection("items")
        
//        itemsRef.document("ost").getDocument() { (document, err ) in
//            if let document = document, document.exists {
//                print(document.data())
//            }
//        }
        
//        itemsRef.getDocuments() {
//            (snapshot, err) in
//            for document in snapshot!.documents {
//
//                print(document.data())
//            }
//        }

        itemsRef.addSnapshotListener() {
            (snapshot, err) in
            var newItems = [Item]()
            for document in snapshot!.documents {
                let item = Item(snapshot: document)
                newItems.append(item)
                //print(item.name)
            }
            //print(newItems.count)
            self.items = newItems
            self.tableView.reloadData()
            
        }
        
        
        
        
    }


}

