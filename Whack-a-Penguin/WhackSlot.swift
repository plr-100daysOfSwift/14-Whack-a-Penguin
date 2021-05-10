//
//  WhackSlot.swift
//  Whack-a-Penguin
//
//  Created by Paul Richardson on 09/05/2021.
//

import UIKit
import SpriteKit

class WhackSlot: SKNode {

	var charNode: SKSpriteNode!
	var isVisible = false
	var isHit = false

	func configure(at position: CGPoint) {
		self.position = position

		let sprite = SKSpriteNode(imageNamed: "whackHole")
		addChild(sprite)

		let cropNode = SKCropNode()
		cropNode.position = CGPoint(x: 0, y: 15)
		cropNode.zPosition = 1
		cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask")

		charNode = SKSpriteNode(imageNamed: "penguinGood")
		charNode.position = CGPoint(x: 0, y: -90)
		charNode.name = "character"
		cropNode.addChild(charNode)

		addChild(cropNode)

	}

	func show(hideTime: Double) {
		if isVisible { return }

		charNode.xScale = 1
		charNode.yScale = 1

		if let mud = SKEmitterNode(fileNamed: "MudParticle") {
			mud.position = charNode.position
			mud.position.y += 90
			addChild(mud)
		}

		charNode.run(SKAction.moveBy(x: 0, y: 80, duration: 0.05))
		isVisible = true
		isHit = false


		if Int.random(in: 0...2)  == 0 {
			charNode.texture = SKTexture(imageNamed: "penguinGood")
			charNode.name = "charFriend"
		} else {
			charNode.texture = SKTexture(imageNamed: "penguinEvil")
			charNode.name = "charEnemy"
		}

		DispatchQueue.main.asyncAfter(deadline: .now() + hideTime * 3.5) { [weak self] in
			self?.hide()
		}
	}

	func hide() {
		if !isVisible { return }
		charNode.run(SKAction.moveBy(x: 0, y: -80, duration: 0.05))
		isVisible = false
	}

	func hit() {
		isHit = true

		if let smoke = SKEmitterNode(fileNamed: "HitParticle.sks") {
			smoke.position = charNode.position
			smoke.position.y += 50
			addChild(smoke)
		}
		let delay = SKAction.wait(forDuration: 0.25)
		let hide = SKAction.moveBy(x: 0, y: -80, duration: 0.5)
		let notVisible = SKAction.run { [unowned self] in
			self.isVisible = false
		}
		charNode.run(SKAction.sequence([delay, hide, notVisible]))
	}
}
