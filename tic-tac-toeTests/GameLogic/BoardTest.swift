//
//  BoardTest.swift
//  tic-tac-toe
//
//  Created by Tushar on 21/09/16.
//  Copyright © 2016 arg. All rights reserved.
//

import XCTest

class BoardTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        let player:Player = Player()
        let tiles = [[player, Optional.None, player], [player, Optional.None, player], [player, Optional.None, player]]
        let board:Board = Board(tiles:tiles)
        
        XCTAssert(board.numberOfMarkedTiles == 6)
    }
        
}
