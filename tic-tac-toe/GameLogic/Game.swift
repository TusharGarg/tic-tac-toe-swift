//
// Created by Tushar on 10/09/16.
// Copyright (c) 2016 arg. All rights reserved.
//

import Foundation

enum GameStatus {
    case nextMove, firstPlayerWins, secondPlayerWins, draw
}

class Game {
    
    private var board: Board
    private var player1: Player
    private var player2: Player
    private(set) var currentPlayer: Player
    private var status: GameStatus = GameStatus.nextMove
    
    init(board: Board, firstPlayer: Player, secondPlayer: Player) {
        
        self.board = board;
        self.player1 = firstPlayer
        self.player2 = secondPlayer
        self.currentPlayer = firstPlayer
    }
    
    func restart() {
        currentPlayer = player1;
        status = GameStatus.nextMove
        board.reset()
    }
    
    func playMove(tileLocation: TileLocation) -> GameStatus {
        if status == GameStatus.nextMove {
            board.markTile(tileLocation, withMark: currentPlayer)
            status = checkForGameStatus()
            currentPlayer = nextPlayer()
        }
        
        return status;
    }
    
    
    
    private func checkForGameStatus() -> GameStatus {
        
        switch board.numberOfMarkedTiles {
        case 5 :
            return GameStatus.nextMove
            
        case _ where board.checkForThreeContinuousMarks() != nil:
            return currentPlayer === player1 ? GameStatus.firstPlayerWins : GameStatus.secondPlayerWins
            
        case 9 :
            return GameStatus.draw
            
        default:
            return GameStatus.nextMove
        }
        
    }
    
    private func nextPlayer() -> Player {
        return currentPlayer === player1 ? player2 : player1;
    }
    
    
}
