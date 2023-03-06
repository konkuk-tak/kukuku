//
//  RealityComposerManager.swift
//  kukuku
//
//  Created by youtak on 2023/03/04.
//

import Foundation
import RealityKit

struct RealityComposerManager {

    private static func createRealityURL(filename: String, fileExtension: String, sceneName: String) -> URL? {
        guard let realityFileURL = Bundle.main.url(forResource: filename, withExtension: fileExtension) else {
            print("Error finding Reality file \(filename).\(fileExtension)")
            return nil
        }
        let realityFileSceneURL = realityFileURL.appendingPathComponent(sceneName, isDirectory: false)
        return realityFileSceneURL
    }

    private static func hamburgerSceneURL() -> URL? {
        createRealityURL(filename: "KUExperience", fileExtension: "reality", sceneName: "TargetScene")
    }

    public static func loadTargetScene() throws -> TargetScene {
        guard let contentsURL = hamburgerSceneURL() else {
            throw RealityFileError.fileNotFound
        }
        let anchorEntity = try RealityComposerManager.TargetScene.loadAnchor(contentsOf: contentsURL)
        return createTargetScene(anchorEntity: anchorEntity)
    }

    private static func createTargetScene(anchorEntity: AnchorEntity) -> TargetScene {
        let targetScene = RealityComposerManager.TargetScene()
        targetScene.anchoring = anchorEntity.anchoring
        targetScene.addChild(anchorEntity)
        return targetScene
    }

    public class TargetScene: Entity, HasAnchoring {

        public var hamburger: Entity? {
            return self.findEntity(named: "hamburger")
        }

        public private(set) lazy var hamburgerTouched = RealityComposerManager.NotifyAction(
            identifier: "hamburgerTouched",
            root: self
        )
    }

    public class NotifyAction {

        public let identifier: String
        private weak var root: Entity?
        public var onAction: ((Entity?) -> Void)?

        fileprivate init(identifier: String, root: Entity?) {
            self.identifier = identifier
            self.root = root

            NotificationCenter.default.addObserver(
                self,
                selector: #selector(actionDidFire(_:)),
                name: NSNotification.Name(rawValue: "RealityKit.NotifyAction"),
                object: nil)
        }

        deinit {
            NotificationCenter.default.removeObserver(
                self,
                name: NSNotification.Name(rawValue: "RealityKit.NotifyAction"),
                object: nil
            )
        }

        @objc func actionDidFire(_ notification: Notification) {
            guard let onAction = onAction else {
                return
            }

            guard let userInfo = notification.userInfo as? [String: Any] else {
                return
            }

            guard let scene = userInfo["RealityKit.NotifyAction.Scene"] as? RealityKit.Scene,
                root?.scene == scene else {
                    return
            }

            guard let identifier = userInfo["RealityKit.NotifyAction.Identifier"] as? String,
                identifier == self.identifier else {
                    return
            }

            let entity = userInfo["RealityKit.NotifyAction.Entity"] as? Entity

            onAction(entity)
        }
    }

    enum RealityFileError: Error {
        case fileNotFound
    }
}
