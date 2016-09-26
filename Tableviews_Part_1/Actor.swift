//
//  Actor.swift
//  Tableviews_Part_1
//
//  Created by Louis Tur on 9/20/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

internal struct Actor {
    
    internal var firstName: String
    internal var lastName: String
    
    init(from data: String) {
        let nameComponents: [String] = data.components(separatedBy: " ")
        
        if let firstName: String = nameComponents.first,
<<<<<<< HEAD
            let lastName: String = nameComponents.last {
=======
        let lastName: String = nameComponents.last {
>>>>>>> 338b20fedb9179bc195ccc634f30fc4f21719001
            self.firstName = firstName
            self.lastName = lastName
        }
        else {
<<<<<<< HEAD
            self.firstName = "unset"
            self.lastName = "unset"
        }
    }
=======
            firstName = "unset"
            lastName = "unset"
        }
    }
    
>>>>>>> 338b20fedb9179bc195ccc634f30fc4f21719001
}
