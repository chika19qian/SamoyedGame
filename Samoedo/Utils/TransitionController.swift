//
//  TransitionController.swift
//  Samoedo
//
//  Created by chika on 2025/2/17.
//

import SwiftUI
import SpriteKit

struct TransitionController: UIViewControllerRepresentable {
    let transition: SKTransition
    let nextView: () -> AnyView

    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        controller.view.backgroundColor = .clear

        let loadingView = UIHostingController(rootView: LoadingView())
        loadingView.view.frame = controller.view.bounds
        loadingView.view.backgroundColor = .clear

        controller.addChild(loadingView)
        controller.view.addSubview(loadingView.view)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let skView = SKView(frame: controller.view.bounds)
            controller.view.addSubview(skView)

            let scene = SKScene(size: skView.bounds.size)
            scene.scaleMode = .resizeFill
            skView.presentScene(scene, transition: transition)

            DispatchQueue.main.asyncAfter(deadline: .now() ) {
                let nextVC = UIHostingController(rootView: nextView())
                nextVC.modalPresentationStyle = .fullScreen
                nextVC.view.backgroundColor = .clear
                scene.view?.window?.rootViewController?.present(nextVC, animated: false) {
                    skView.presentScene(nil)
                }
            }
        }
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
