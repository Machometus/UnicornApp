//
//  Unicorn+Mock.swift
//  UnicornApp
//
//  Created by Mohamed Salem on 31.10.23.
//

import Foundation

extension Unicorn {
    
    /// A static constant representing a `Unicorn` named Cassiopeia with a red flavor.
    static let cassiopeia = Unicorn(
        name: "Cassiopeia",
        flavour: .red
    )
    
    /// A static constant representing a `Unicorn` named Hippolyta with a green flavor.
    static let hippolyta = Unicorn(
        name: "Hippolyta",
        flavour: .green
    )
    
    /// A static constant representing a `Unicorn` named Zephyra with a blue flavor.
    static let zephyra = Unicorn(
        name: "Zephyra",
        flavour: .blue
    )
    
    /// An array of sample `Unicorn` instances to be used for example data or testing purposes.
    static let sample: [Unicorn] = [
        .cassiopeia,
        .hippolyta,
        .zephyra
    ]
}
