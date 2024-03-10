//
//  GameScene.swift
//  Zeus-Chronicles
//
//  Created by John on 06.03.2024.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    public var gameDelegate: gameDelegate!
    
    private var isGameOver = false

    private var greenBasket: SKSpriteNode!
    private var redBasket: SKSpriteNode!

    override func didMove(to view: SKView) {
        setupScene()
        setupBaskets()
        spawnRandomShapes()
    }

    private func setupScene() {
        scene?.size = (view?.frame.size)!
        backgroundColor = .white
        let background = SKSpriteNode(imageNamed: "background")
        let aspectRatio = background.size.width / background.size.height
                let newWidth = size.height * aspectRatio
                background.size = CGSize(width: newWidth, height: size.height)
                background.position = CGPoint(x: size.width/2, y: size.height/2)
                background.zPosition = -3
                addChild(background)
        
    }

    private func setupBaskets() {
        let basketSize = CGSize(width: 100, height: 100)
        greenBasket = createBasket(at: CGPoint(x: size.width / 4, y: 100), size: basketSize, name: "box_Y")
        greenBasket.name = "greenBasket"
        redBasket = createBasket(at: CGPoint(x: size.width / 4 * 3, y: 100), size: basketSize, name: "box_R")
        redBasket.name = "redBasket"
        addChild(greenBasket)
        addChild(redBasket)
    }

    private func createBasket(at position: CGPoint, size: CGSize, name: String) -> SKSpriteNode {
        let basket = SKSpriteNode(imageNamed: name)
        basket.position = position
        basket.physicsBody = SKPhysicsBody(rectangleOf: size)
        basket.scale(to: size)
        basket.physicsBody?.isDynamic = false
        return basket
    }

    private func spawnRandomShapes() {
        
        let spawnAction = SKAction.run {
                switch Int.random(in: 0...3) {
                case 0:
                    self.spawnTwoShapes()
                    break
                default:
                    self.spawnShape()
                    break
                }
        }
        
        let waitAction = SKAction.wait(forDuration: 2.0)
        let sequenceAction = SKAction.sequence([spawnAction, waitAction])
        let repeatAction = SKAction.repeatForever(sequenceAction)
        run(repeatAction)
    }
    
    private func gameOver() {
        self.removeAllActions()
        enumerateChildNodes(withName: "red") { (node, _) in
            if let shape = node as? SKSpriteNode {
                shape.removeAllActions()
                }
            }
        enumerateChildNodes(withName: "green") { (node, _) in
            if let shape = node as? SKSpriteNode {
                shape.removeAllActions()
                }
            }
        let delay = SKAction.wait(forDuration: 0.5)
                    let sceneChange = SKAction.run {
                        let newGameScene = GameScene()
                        self.gameDelegate.score = 0
                        newGameScene.gameDelegate = self.gameDelegate
                        newGameScene.delegate = self.delegate
                        newGameScene.scaleMode = .aspectFit
                        self.gameDelegate.skView.presentScene(newGameScene, transition: .flipHorizontal(withDuration: 0.5))
                    }
                    run(.sequence([delay, sceneChange]))
    }

    private func spawnShape() {
        let colors: [String] = ["symb_Y", "symb_R"]
        let positions = [size.width / 4, size.width / 4 * 3]
        let randomColor = colors.randomElement()!

        let shapeSize = CGSize(width: 50, height: 50)
        let shape = SKSpriteNode(imageNamed: randomColor)
        shape.scale(to: shapeSize)
        shape.position = CGPoint(x: positions.randomElement()!, y: size.height - 50)
        if randomColor == "symb_Y" {
            shape.name = "green"
        } else {
            shape.name = "red"
        }
        addChild(shape)

        let moveAction = SKAction.moveTo(y: 50, duration: 5.0)
        let removeAction = SKAction.removeFromParent()
        shape.run(SKAction.sequence([moveAction, removeAction]))
    }
    
    private func spawnTwoShapes() {
        var colors: [String] = ["symb_Y", "symb_R"]
        colors.shuffle()
        var positions = [size.width / 4, size.width / 4 * 3]

        let shapeSize = CGSize(width: 50, height: 50)
        let shape1 = SKSpriteNode(imageNamed: colors.first!)
        shape1.scale(to: shapeSize)
        shape1.position = CGPoint(x: positions.first!, y: size.height - 50)
        addChild(shape1)
        let shape2 = SKSpriteNode(imageNamed: colors.last!)
        shape2.scale(to: shapeSize)
        shape2.position = CGPoint(x: positions.last!, y: size.height - 50)

        addChild(shape2)
        if colors.first == "symb_Y" {
            shape1.name = "green"
            shape2.name = "red"
        } else {
            shape1.name = "red"
            shape2.name = "green"
        }
        let moveAction = SKAction.moveTo(y: 50, duration: 5.0)
        let removeAction = SKAction.removeFromParent()
        shape1.run(SKAction.sequence([moveAction, removeAction]))
        shape2.run(SKAction.sequence([moveAction, removeAction]))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isGameOver {
            for touch in touches {
                let touchLocation = touch.location(in: self)
                
                let moveRightAction = SKAction.moveTo(x: size.width / 4 * 3, duration: 0.3)
                let moveLeftAction = SKAction.moveTo(x: size.width / 4, duration: 0.3)
                
                if greenBasket.position.x < redBasket.position.x {
                    greenBasket.run(moveRightAction)
                    redBasket.run(moveLeftAction)
                } else {
                    greenBasket.run(moveLeftAction)
                    redBasket.run(moveRightAction)
                }
            }
        }
    }

    override func update(_ currentTime: TimeInterval) {
        enumerateChildNodes(withName: "green") { (node, _) in
                if let shape = node as? SKSpriteNode, let greenbasket = self.childNode(withName: "greenBasket") as? SKSpriteNode, let redbasket = self.childNode(withName: "redBasket") as? SKSpriteNode {
                    if shape.frame.intersects(greenbasket.frame) {
                        self.handleCollision(with: shape)
                        shape.removeFromParent()
                    } else if shape.frame.intersects(redbasket.frame) {
                        shape.removeFromParent()
                        self.isGameOver = true
                        print("Lose")
                        self.gameOver()
                    }
                }
            }
        
        enumerateChildNodes(withName: "red") { (node, _) in
                if let shape = node as? SKSpriteNode, let greenbasket = self.childNode(withName: "greenBasket") as? SKSpriteNode, let redbasket = self.childNode(withName: "redBasket") as? SKSpriteNode {
                    if shape.frame.intersects(redbasket.frame) {
                        self.handleCollision(with: shape)
                        shape.removeFromParent()
                    } else if shape.frame.intersects(greenbasket.frame){
                        shape.removeFromParent()
                        self.isGameOver = true
                        print("Lose")
                        self.gameOver()
                    }
                }
            }
    }
    
    
    
    private func handleCollision(with shape: SKSpriteNode) {
        gameDelegate.score += 1
        LightningManager.shared.addLightPoints(1)
    }
}

