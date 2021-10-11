//
//  StudType.swift
//  
//
//  Created by Takuto Nakamura on 2021/10/10.
//

import Foundation

public enum StudType: Int {
    case round
    case roundPlate
    case square
    case squarePlate
    
    public var label: String {
        switch self {
        case .round:       return "Round"
        case .roundPlate:  return "Round Plate"
        case .square:      return "Square"
        case .squarePlate: return "Square Plate"
        }
    }
}
