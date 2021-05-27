//
//  DocumentView.swift
//  Mola
//
//  Created by 김민창 on 2021/05/27.
//

import SwiftUI

class DocumentView: UIViewController {
    var document: UIDocument?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Access the document
        document?.open(completionHandler: { (success) in
            if success {
                // Display the content of the document, e.g.:
                print(self.document?.fileURL.lastPathComponent)
            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            }
        })
    }
}

