//
//  Constants.swift
//  EtisalatRevamp
//
//  Created by Faraz Haider on 09/12/2019.
//  Copyright © 2019 Faraz Haider. All rights reserved.
//

import Foundation

class Constants: NSObject {
    
    struct Error {
        static let genericErrorDomain = ""
        static let genericErrorCode = 111111
        static let genericErrorMessage = "Something went wrong"
        
        static let networkErrorDomain = ""
        static let networkErrorCode = -1009
        static let networkErrorMessage = "Network is not working. Please try again."
        static let networkErrorTitle = "Network not found"
        static let networkErrorSubTitle = "Please try again"
        
    }
    
}
