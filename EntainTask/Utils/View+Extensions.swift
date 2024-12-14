//
//  View+Extensions.swift
//  EntainTask
//
//  Created by Prajoth Dsa on 14/12/2024.
//

import Foundation
import SwiftUI

public extension View {
    /// Apply modifiers to a SwiftUI `View` using an unwrapped optional value
    ///
    /// Example Usage
    /// ```
    /// view
    ///     .if(let: someOptionalValue) { view, unwrappedValue in
    ///         view
    ///             .modifier(using: unwrappedValue)
    ///     }
    /// ```
    @ViewBuilder
    func `if`<Property, TrueContent: View>(`let` property: Property?,
                                           trueContent: (Self, Property) -> TrueContent) -> some View {
        if let property {
            trueContent(self, property)
        } else {
            self
        }
    }
}
