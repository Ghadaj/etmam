////
////  CSVDocument.swift
////  calenderSwift
////
////  Created by Danya T on 29/11/1443 AH.
////
//
//import SwiftUI
//import UniformTypeIdentifiers
//struct CSVDocument: FileDocument {
//  static var readableContentTypes: [UTType] { [.content] }
//  var contentOfFile: String
//  init(contentOfFile: String) {
//    self.contentOfFile = contentOfFile
//  }
//  init(configuration: ReadConfiguration) throws {
//    guard let data = configuration.file.regularFileContents,
//       let string = String(data: data, encoding: .utf8)
//    else {
//      throw CocoaError(.fileReadCorruptFile)
//    }
//    contentOfFile = string
//  }
//  func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
//    return FileWrapper(regularFileWithContents: contentOfFile.data(using: .utf8)!)
//  }
//}
