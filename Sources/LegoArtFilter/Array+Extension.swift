//
//  Array+Extension.swift
//  
//
//  Created by Takuto Nakamura on 2021/10/12.
//

extension Array {
    func chunked(by chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: chunkSize)
            .map { Array(self[$0 ..< Swift.min($0 + chunkSize, self.count)]) }
    }
}
