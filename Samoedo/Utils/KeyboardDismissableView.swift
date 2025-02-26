//
//  KeyboardDismissableView.swift
//  Samoedo
//
//  Created by chika on 2025/2/26.
//

import UIKit

class KeyboardDismissableView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupKeyboardDismissal()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupKeyboardDismissal()
    }

    private func setupKeyboardDismissal() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        self.endEditing(true)
    }
}
