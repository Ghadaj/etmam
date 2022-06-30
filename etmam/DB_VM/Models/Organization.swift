//
//  Organization.swift
//  testFirebase
//
//  Created by Danya T on 02/11/1443 AH.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct Orgnization:  Codable, Identifiable {
  @DocumentID var id : String?

    var OrgName : String?
   // var OrgLoc : String?
    var Package : String?
    var OrgOwner : String?
    var OrgAdmins : [String]?
    var OrgUsers : [String]?
    var lat :Double
    var lng :Double

    init(OrgName: String, Package:
         String, OrgOwner: String, OrgAdmins: [String], OrgUsers: [String] , lat :Double , lng :Double ){
        self.OrgName = OrgName
       // self.OrgLoc = OrgLoc
        self.Package = Package
        self.OrgOwner = OrgOwner
        self.OrgAdmins = OrgAdmins
        self.OrgUsers = OrgUsers
        self.lat = lat
        self.lng = lng

    }
}
    
    
    
  
    
 
