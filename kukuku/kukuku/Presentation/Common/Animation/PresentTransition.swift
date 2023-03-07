//
//  AnimationTransition.swift
//  kukuku
//
//  Created by youtak on 2023/03/07.
//

import UIKit

final class PresentTransition: NSObject, UIViewControllerAnimatedTransitioning {

    let originFrame: CGRect
    let duration = 1.0

    init(originFrame: CGRect) {
        self.originFrame = originFrame
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: .to) else {
            return
        }

        let radius = containerView.frame.width
        let startFrame = CGRect(
            x: originFrame.origin.x + originFrame.width / 2,
            y: originFrame.origin.y + originFrame.height / 2,
            width: 0,
            height: 0
        )

        toView.frame = startFrame
        containerView.addSubview(toView)
        toView.clipsToBounds = true

        // swiftlint: disable: vertical_parameter_alignment_on_call
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0
        ) {
            UIView.addKeyframe(
                withRelativeStartTime: 0,
                relativeDuration: 0.5) {
                    toView.layer.cornerRadius = containerView.frame.width / 2
                    toView.frame = CGRect(
                        x: 0,
                        y: startFrame.origin.y - radius,
                        width: radius,
                        height: radius
                    )
                }

            UIView.addKeyframe(
                withRelativeStartTime: 0.5,
                relativeDuration: 0.5) {
                    toView.frame = containerView.frame
                    toView.layer.cornerRadius = 0
                }
        } completion: { _ in
            transitionContext.completeTransition(true)
        }
    }
}
