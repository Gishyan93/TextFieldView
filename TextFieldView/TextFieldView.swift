//
//  TextFieldView.swift
//  TextFieldView
//
//  Created by Tigran Gishyan on 20.04.22.
//

import UIKit

struct TextFieldViewData {
    enum KeyboardType {
        case emailPad
        case numberPad
        case namePhonePad
    }

    var keyboardType: KeyboardType
    var isSecure: Bool
    var title: String
}

class TextFieldView: UIView {
    var titleLabel: UILabel!
    var textInputView: UIView!
    var textField: UITextField!

    var eyeButton: UIButton!

    var isSecureEnabled: Bool = true
    var onTapAction: ((String) -> Void)?
    var onEndTapAction: ((String) -> Void)?

    init() {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        initTitleLabel()
        initTextView()
        initTextField()
        initEyeButton()
        constructHierarchy()
        activateConstraints()

        setupTextFieldActions()

        eyeButton.addTarget(self, action: #selector(eyeButtonTapped), for: .touchUpInside)
    }

    func set(data: TextFieldViewData) {
        switch data.keyboardType {
        case .emailPad:
            textField.keyboardType = .emailAddress
        case .namePhonePad:
            textField.keyboardType = .namePhonePad
        case .numberPad:
            textField.keyboardType = .numberPad
        }

        textField.isSecureTextEntry = data.isSecure
        titleLabel.text = data.title
        eyeButton.isHidden = !data.isSecure
    }

    private func setupTextFieldActions() {
        textField.addTarget(self, action: #selector(startEditing), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(editing), for: .editingChanged)
        textField.addTarget(self, action: #selector(finishEditing), for: .editingDidEnd)
    }

    @objc func startEditing() {
        textInputView.layer.borderColor = UIColor.blue.cgColor
    }

    @objc func editing(sender: UITextField) {
        onTapAction?(sender.text ?? "")
    }

    @objc func finishEditing(sender: UITextField) {
        textInputView.layer.borderColor = UIColor.black.cgColor
        onEndTapAction?(sender.text ?? "")
    }

    @objc func eyeButtonTapped() {

        if isSecureEnabled {
            let image = UIImage(systemName: "eye.slash.circle.fill")?
                .withTintColor(.black, renderingMode: .alwaysOriginal)
            eyeButton.setImage(image, for: .normal)
        } else {
            let image = UIImage(systemName: "eye.circle.fill")?
                .withTintColor(.black, renderingMode: .alwaysOriginal)
            eyeButton.setImage(image, for: .normal)
        }

        textField.isSecureTextEntry = !isSecureEnabled
        isSecureEnabled.toggle()
    }
}

// MARK: - Layout
extension TextFieldView {
    private func initTitleLabel() {
        titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        titleLabel.text = "Title"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func initTextView() {
        textInputView = UIView()
        textInputView.layer.cornerRadius = 12
        textInputView.layer.borderWidth = 1
        textInputView.layer.borderColor = UIColor.black.cgColor
        textInputView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func initEyeButton() {
        eyeButton = UIButton(type: .system)
        let image = UIImage(systemName: "eye.circle.fill")?
            .withTintColor(.black, renderingMode: .alwaysOriginal)
        eyeButton.setImage(image, for: .normal)
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
    }

    private func initTextField() {
        textField = UITextField()
        textField.font = .systemFont(ofSize: 14, weight: .semibold)
        textField.textColor = .black
        textField.placeholder = "Placeholder Text"
        textField.translatesAutoresizingMaskIntoConstraints = false
    }

    private func constructHierarchy() {
        addSubview(titleLabel)
        addSubview(textInputView)
        textInputView.addSubview(textField)
        textInputView.addSubview(eyeButton)
    }

    private func activateConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),

            textInputView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            textInputView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textInputView.trailingAnchor.constraint(equalTo: trailingAnchor),
            textInputView.bottomAnchor.constraint(equalTo: bottomAnchor),

            textField.leadingAnchor.constraint(equalTo: textInputView.leadingAnchor, constant: 12),
            textField.trailingAnchor.constraint(equalTo: textInputView.trailingAnchor),
            textField.centerYAnchor.constraint(equalTo: textInputView.centerYAnchor),

            eyeButton.topAnchor.constraint(equalTo: textInputView.topAnchor),
            eyeButton.trailingAnchor.constraint(equalTo: textInputView.trailingAnchor),
            eyeButton.bottomAnchor.constraint(equalTo: textInputView.bottomAnchor),
            eyeButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}
