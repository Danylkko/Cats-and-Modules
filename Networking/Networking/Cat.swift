//
//  Cat.swift
//  Networking
//
//  Created by Danylo Litvinchuk on 19.06.2022.
//

import Foundation
import SwiftUI

public struct Cat: Codable, Identifiable {
    public let id: String
    public let url: String
    public let width: Int
    public let height: Int
}
