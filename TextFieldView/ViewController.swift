//
//  ViewController.swift
//  TextFieldView
//
//  Created by Tigran Gishyan on 20.04.22.
//

import UIKit

class ViewController: UIViewController {
    var stackView: UIStackView!
    var emailTextView: TextFieldView!
    var passwordTextView: TextFieldView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false

        initStackView()
        initEmailTextViews()
        constructHierarchy()
        activateConstraints()

//        setupEmailView()
//        setupPasswordView()
    }

//    func setupEmailView() {
//        emailTextView.set(
//            data: TextFieldViewData(
//                keyboardType: .emailPad,
//                isSecure: false,
//                title: "Email"
//            )
//        )
//
//        emailTextView.onEndTapAction = { text in
//            print("Ended text: \(text)")
//        }
//    }
//
//    func setupPasswordView() {
//        passwordTextView.set(
//            data: TextFieldViewData(keyboardType: .emailPad, isSecure: true, title: "Password")
//        )
//    }
}

// MARK: - Layout
extension ViewController {
    private func initStackView() {
        stackView = UIStackView()
        stackView.spacing = 15
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func initEmailTextViews() {
        emailTextView = TextFieldView()
        emailTextView.translatesAutoresizingMaskIntoConstraints = false

        passwordTextView = TextFieldView()
        passwordTextView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func constructHierarchy() {
        view.addSubview(stackView)
    }

    private func activateConstraints() {

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
        ])

        NSLayoutConstraint.activate([
            emailTextView.heightAnchor.constraint(equalToConstant: 60),
            passwordTextView.heightAnchor.constraint(equalToConstant: 60)
        ])

        stackView.addArrangedSubview(emailTextView)
        stackView.addArrangedSubview(passwordTextView)
    }
}
