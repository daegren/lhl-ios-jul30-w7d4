//
//  ViewController.swift
//  DynamicsDemo
//
//  Created by David Mills on 2018-09-13.
//  Copyright © 2018 David Mills. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var grayBox : UIView!
    @IBOutlet weak var boundaryBox : UIView!
    
    private var animator : UIDynamicAnimator!
    private var gravityBehaviour : UIGravityBehavior!
    private var collisionBehaviour : UICollisionBehavior!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnim()
    }
    
    private func setupAnim() {
        animator = UIDynamicAnimator(referenceView: view)
        
        gravityBehaviour = UIGravityBehavior(items: [grayBox])
        
        animator.addBehavior(gravityBehaviour)
        
        collisionBehaviour = UICollisionBehavior(items: [grayBox])
        
        collisionBehaviour.translatesReferenceBoundsIntoBoundary = true
//        collisionBehaviour.addBoundary(withIdentifier: "superview" as NSCopying, for: UIBezierPath(rect: view.bounds))

        
        collisionBehaviour.addBoundary(withIdentifier: "boundaryBox" as NSCopying, for: UIBezierPath(rect: boundaryBox.frame))
        
        
        collisionBehaviour.collisionDelegate = self
        
        animator.addBehavior(collisionBehaviour)
        
        let dynamicItemBehaviour = UIDynamicItemBehavior(items: [grayBox])
        dynamicItemBehaviour.elasticity = 0.6
        dynamicItemBehaviour.addAngularVelocity(2.5, for: grayBox)
        
        animator.addBehavior(dynamicItemBehaviour)
    }

}

extension ViewController : UICollisionBehaviorDelegate {
    func collisionBehavior(_ behavior: UICollisionBehavior,
                           beganContactFor item: UIDynamicItem,
                           withBoundaryIdentifier identifier: NSCopying?,
                           at p: CGPoint) {
        print("Collision detected, \(String(describing: identifier))")
        
        let collidingItem = item as! UIView
        collidingItem.backgroundColor = .yellow
        
        UIView.animate(withDuration: 0.3) {
            collidingItem.backgroundColor = .lightGray
        }
    }
}











