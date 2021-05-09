//
//  WhackSlot.swift
//  Whack-a-Penguin
//
//  Created by Paul Richardson on 09/05/2021.
//

import UIKit
import SpriteKit

class WhackSlot: SKNode {

	func configure(at position: CGPoint) {
		self.position = position

		let sprite = SKSpriteNode(imageNamed: "whackHole")
		addChild(sprite)
	}
}
