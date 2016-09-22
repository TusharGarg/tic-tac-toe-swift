//
//  GameViewController.swift
//  tic-tac-toe
//
//  Created by Tushar on 08/09/16.
//  Copyright (c) 2016 arg. All rights reserved.
//


import UIKit


class GameViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var tilesCollectionView: UICollectionView!
    @IBOutlet weak var controlButton: UIButton!
    
    private let firstPlayer = Player("Norris", "0")
    private let secondPlayer = Player("Rajni", "X")
    private let board = Board()
    //find a way to intialize it here only
    private var game:Game!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game = Game(board:board, firstPlayer: firstPlayer, secondPlayer: secondPlayer)
        
        statusLabel.text = "\(game.currentPlayer.name), your turn"
        controlButton.hidden = true
    }

    @IBAction func resetTouched(sender: UIButton) {
        statusLabel.text = ""
        tilesCollectionView.reloadData()
        tilesCollectionView.userInteractionEnabled = true
        game.restart()
    }

}

extension GameViewController: UICollectionViewDataSource {

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("CELL", forIndexPath: indexPath)
        return cell
    }

}

extension GameViewController: UICollectionViewDelegate {

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let tileLocation = TileLocation(row: indexPath.section, col: indexPath.item)
        if !board.isTileMarked(tileLocation) {
            let cell = collectionView.cellForItemAtIndexPath(indexPath) as! TileCollectionViewCell
            cell.setImage(game.currentPlayer.markSymbol)
            cell.userInteractionEnabled = false
            updateGameStatus(game.playMove(tileLocation))
        }
    }
    
    func updateGameStatus(status: GameStatus) {
        
        switch status {
        case .nextMove:
            statusLabel.text = "\(game.currentPlayer.name), your turn"
            
        case .firstPlayerWins:
            statusLabel.text = "\(firstPlayer.name), you win"
            prepareForReset()
            
        case .secondPlayerWins:
            statusLabel.text = "\(secondPlayer.name), your win"
            prepareForReset()
            
        case .draw:
            statusLabel.text = "It's a draw"
            prepareForReset()
            
        }
    }
    
    func prepareForReset() {
        tilesCollectionView.userInteractionEnabled = false
        controlButton.hidden = false
    }
    
}


