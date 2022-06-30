//
//  ImportSheetApp.swift
//  calenderSwift
//
//  Created by Danya T on 29/11/1443 AH.
//

import SwiftUI
//@main
struct ImportSheetApp: App {
  init() {
    UITableView.appearance().backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.00)
   }
  var body: some Scene {
    WindowGroup {
      Today()
    }
  }
}
