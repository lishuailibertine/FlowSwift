//
//  File.swift
//  
//
//  Created by li shuai on 2022/9/2.
//

import Foundation

extension Array where Element == UInt8 {
    /// Convert to `Data` type
    var data: Data { .init(self) }
    
}
