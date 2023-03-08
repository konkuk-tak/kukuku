//
//  DismissTransition.swift
//  kukuku
//
//  Created by youtak on 2023/03/07.
//

import UIKit

final class DismissTransition: NSObject, UIViewControllerAnimatedTransitioning {

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

        guard let fromView = transitionContext.view(forKey: .from) else {
            return
        }
        guard let toView = transitionContext.view(forKey: .to) else {
            return
        }
        guard let fromViewSnapShot = fromView.snapshotView(afterScreenUpdates: false) else {
            return
        }

        containerView.addSubview(toView)
        containerView.addSubview(fromViewSnapShot)

        let fromViewWidth = fromView.frame.width
        let radius = fromViewWidth / 2

        let endFrame = CGRect(
            x: originFrame.origin.x + originFrame.width / 2,
            y: originFrame.origin.y + originFrame.height / 2,
            width: 0,
            height: 0
        )

        fromViewSnapShot.clipsToBounds = true

        // swiftlint: disable: vertical_parameter_alignment_on_call
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0
        ) {
            UIView.addKeyframe(
                withRelativeStartTime: 0,
                relativeDuration: 0.5) {
                    fromViewSnapShot.layer.cornerRadius = radius
                    fromViewSnapShot.frame = CGRect(
                        x: 0,
                        y: endFrame.origin.y - radius,
                        width: fromViewWidth,
                        height: fromViewWidth
                    )
                }

            UIView.addKeyframe(
                withRelativeStartTime: 0.5,
                relativeDuration: 0.5) {
                    fromViewSnapShot.layer.cornerRadius = 0
                    fromViewSnapShot.frame = endFrame
                }
        } completion: { _ in
            transitionContext.completeTransition(true)
        }
    }
}
