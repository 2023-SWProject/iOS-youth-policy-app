//
//  CenterStore.swift
//  YouthPolicyPedia
//
//  Created by 김태성 on 2023/06/09.
//

import Foundation
import Firebase
import FirebaseFirestore

class CenterStore: ObservableObject {
    @Published var centers: [Center] = []
    @Published var selectedLocation: [String: String] = ((UserDefaults.standard.dictionary(forKey: "myLocation") ?? [:]) as? [String: String] ?? [:])
    let database = Firestore.firestore()
    
    func fetchCenters() {
        print("Centers Fetch Start")
        database.collection("PolicyDataSpc_New")
            .whereField("srcPolyBizSecd", isEqualTo: selectedLocation.first?.value ?? "") // 지역 필터링
            .getDocuments { (snapshot, error) in
                self.centers.removeAll()
                
                if let snapshot {
                    for document in snapshot.documents {
                        let docData = document.data()
                        let adress: String = docData["adress"] as? String ?? ""
                        let spcid: Int = docData["spcid"] as? Int ?? 0
                        let spcname: String = docData["spcname"] as? String ?? ""
                        let scrPolyBizSecd: String = docData["scrPolyBizSecd"] as? String ?? ""
                        let url: String = docData["url"] as? String ?? ""
                        
                        let center: Center = Center(adress: adress, spcid: spcid, spcname: spcname, scrPolyBizSecd: scrPolyBizSecd, url: url)
                        self.centers.append(center)
                    }
                }
            }
    }
}
