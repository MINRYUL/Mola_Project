//
//  Document.swift
//  Mola
//
//  Created by 김민창 on 2021/05/27.
//

import Foundation
import UIKit

class Document: UIDocument {
    var dataDocument: Data?
    
    override func contents(forType typeName: String) throws -> Any {
        // Encode your document with an instance of NSData or NSFileWrapper
        return Data()
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        // Load your document from contents
    }
    
    override func revert(toContentsOf: URL, completionHandler: ((Bool) -> Void)?) {
        
    }

}

