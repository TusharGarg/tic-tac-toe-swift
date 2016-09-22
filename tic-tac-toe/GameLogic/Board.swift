//
// Created by Tushar on 10/09/16.
// Copyright (c) 2016 arg. All rights reserved.
//

import Foundation

class Board {
    
    private static let boardSize:Int = 3
    private(set) var numberOfMarkedTiles:Int = 0
    
    private lazy var tiles = [[Player?]](count:Board.boardSize,
                                         repeatedValue:[Player?](count:Board.boardSize, repeatedValue: Optional.None))
    
    init(){
        
    }
    
    init(tiles:[[Player?]]) {
        self.tiles = tiles
        
        self.numberOfMarkedTiles = tiles.reduce(0, combine: {
            return $0 + $1.reduce(0, combine: {
                return $0 + ($1 != nil ? 1 : 0)
            })
        })
    }
    
    
    func reset() {
        
        //TODO: refactor to extract initialization in one place
        tiles = [[Player?]](count:Board.boardSize, repeatedValue:[Player?](count:Board.boardSize, repeatedValue: Optional.None))
        numberOfMarkedTiles = 0;
        
    }
    
    func markTile(location: TileLocation, withMark mark: Player) -> Bool{
        if nil == tiles[location.row][location.col] {
            tiles[location.row][location.col] = mark
            numberOfMarkedTiles+=1
            return true;
        }
        return false;
    }
    
    
    func isTileMarked(location: TileLocation) -> Bool {
        
        return nil != tiles[location.row][location.col]
    }
    
    
    func checkForThreeContinuousMarks() -> [TileLocation]? {
        
        for index in 0...Board.boardSize-1 {
            
            if let locations = checkForSameMarkInRow(index) {
                return locations
            }
            
            if let locations = checkForSameMarkInColumn(index) {
                return locations
            }
            
        }
        
        
        return checkForSameMarkInDiagaonals();
    }
    
    
    private func checkForSameMarkInRow(row:Int) -> [TileLocation]? {
        
        if( nil != tiles[row][0] && tiles[row][0] === tiles[row][1] && tiles[row][1] === tiles[row][2]) {
            
            return [TileLocation(row :row, col :0), TileLocation(row: row,col:1), TileLocation(row:row,col:2)]
        }
        return Optional.None
    }
    
    
    private func checkForSameMarkInColumn(col:Int) -> [TileLocation]? {
        
        if( nil != tiles[0][col] && tiles[0][col] === tiles[1][col] && tiles[1][col] === tiles[2][col]) {
            
            return [TileLocation(row :0, col :col), TileLocation(row:1,col:col), TileLocation(row:2,col:col)]
        }
        return Optional.None
    }
    
    private func checkForSameMarkInDiagaonals() -> [TileLocation]? {
        
        if( nil != tiles[0][0] && tiles[0][0] === tiles[1][1] && tiles[1][1] === tiles[2][2]) {
            
            return [TileLocation(row :0, col :0), TileLocation(row:1,col:1), TileLocation(row:2,col:2)]
        }
        if( nil != tiles[0][2] && tiles[0][2] === tiles[1][1] && tiles[1][1] === tiles[2][0]) {
            
            return [TileLocation(row :0, col :2), TileLocation(row:1,col:1), TileLocation(row:2,col:0)]
        }

        return Optional.None
    }


    
}
