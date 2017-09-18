//
//  LevenshteinDistance.swift
//  Ticker
//
//  Created by olddonkey on 2017/9/18.
//  Copyright © 2017年 olddonkey. All rights reserved.
//

import Foundation

class LevenshteiDistance{
    enum action{
        case update, insertion, deletion
    }
    
    static func computeColumnAction(source: String, target: String) -> [action] {
        let source = Array(source.characters)
        let target = Array(target.characters)
        
        let sourceLength = source.count
        let targetLength = target.count
        
        if sourceLength == targetLength {
            var result = [action]()
            for _ in 0..<sourceLength {
                result.append(.update)
            }
            return result
        }
        
        let numberOfRows = sourceLength + 1
        let numberOfCols = targetLength + 1
        
        var matrix: [[Int]] = [[Int]]()
        
        for _ in 0..<numberOfRows {
            matrix.append([Int](repeating: 0, count: numberOfCols))
        }
        
        for i in 0..<numberOfRows {
            matrix[i][0] = i
        }
        
        for j in 0..<numberOfCols {
            matrix[0][j] = j
        }
        
        for i in 1..<numberOfRows {
            for j in 1..<numberOfCols {
                if source[i-1] != target[j-1] {
                    matrix[i][j] = min(matrix[i][j-1] + 1, matrix[i-1][j] + 1, matrix[i-1][j-1] + 1)
                }else {
                    matrix[i][j] = matrix[i-1][j-1]
                }
            }
        }
        
        var resultList: [action] = [action]()
        
        var row = numberOfRows - 1
        var col = numberOfCols - 1
        
        while row > 0 || col > 0 {
            if row == 0 {
                resultList.append(.insertion)
                col -= 1
            }else if col == 0 {
                resultList.append(.deletion)
                row -= 1
            }else {
                let insert = matrix[row][col-1]
                let delete = matrix[row-1][col]
                let replace = matrix[row-1][col-1]
                
                if insert < delete && insert < replace {
                    resultList.append(.insertion)
                    col -= 1
                }else if delete < replace {
                    resultList.append(.deletion)
                    row -= 1
                }else {
                    resultList.append(.update)
                    row -= 1
                    col -= 1
                }
            }
        }
        
        let result = Array(resultList.reversed())
        return result
    }
    
}
