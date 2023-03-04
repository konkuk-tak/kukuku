//
//  RealityComposerManager.swift
//  kukuku
//
//  Created by youtak on 2023/03/04.
//

import Foundation

struct RealityComposerManager {

    private static func createRealityURL(filename: String, fileExtension: String, sceneName: String) -> URL? {
        guard let realityFileURL = Bundle.main.url(forResource: filename, withExtension: fileExtension) else {
            print("Error finding Reality file \(filename).\(fileExtension)")
            return nil
        }
        let realityFileSceneURL = realityFileURL.appendingPathComponent(sceneName, isDirectory: false)
        return realityFileSceneURL
    }

    static func hamburgerSceneURL() -> URL? {
        createRealityURL(filename: "HamburgerScene", fileExtension: "reality", sceneName: "hamburger")
    }
}
