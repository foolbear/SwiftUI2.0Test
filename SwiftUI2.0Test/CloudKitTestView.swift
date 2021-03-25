//
//  CloudKitTestView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2021/2/10.
//

import SwiftUI
import CloudKit

struct CloudKitTestView: View {
    @State private var id: String? = nil
    @State private var name: String? = nil
    let containerIdentifier = "iCloud.com.foolbear.cinema"
    
    var body: some View {
        Text("id = \(id ?? "-"), name = \(name ?? "-")")
            .onAppear(perform: onAppear)
            .navigationTitle("CloudKit")
    }
    
    func onAppear() {
        let container = CKContainer(identifier: containerIdentifier)
        container.fetchUserRecordID { record, error in
            guard let record = record, error == nil else {
                print("error: \(String(describing: error))")
                return
            }
            print("id = \(record.recordName)")
            DispatchQueue.main.async {
                id = record.recordName
            }
        }
        let database = container.publicCloudDatabase
        let predicate = NSPredicate(format: "CD_id = %@", id ?? "")
        let query = CKQuery(recordType: "CD_User", predicate: predicate)
        database.perform(query, inZoneWith: nil) { results, error in
            if let error = error {
                print("error: \(error)")
                return
            }
            guard let result = results?.first, let name = result["CD_name"] as? String else { return }
            print("name = \(name)")
            DispatchQueue.main.async {
                self.name = name
            }
        }
    }
}

struct CloudKitTestView_Previews: PreviewProvider {
    static var previews: some View {
        CloudKitTestView()
    }
}
