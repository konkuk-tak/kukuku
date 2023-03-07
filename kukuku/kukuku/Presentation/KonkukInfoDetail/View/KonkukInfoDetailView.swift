//
//  KonkukInfoDetailView.swift
//  kukuku
//
//  Created by youtak on 2023/03/02.
//

import Combine
import UIKit

import FlexLayout
import PinLayout

final class KonkukInfoDetailView: UIView {

    // MARK: - Property
    private let containerView = UIView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let infoImageView = UIImageView()
    private let imageReferenceLabel = UILabel()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let completeButton = KUDefaultButton(title: "done".localized, style: .heavy)

    var hasImage: Bool { return infoImageView.image != nil }

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
//        configureSubView(konkukInfo: )
        configureFlexLayout()
    }

    init(konkukInfo: KonkukInfo) {
        super.init(frame: .zero)
        configureView()
        configureSubView(konkukInfo: konkukInfo)
        configureFlexLayout()
        titleLabel.text = konkukInfo.title
        descriptionLabel.text = konkukInfo.description
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.pin.all(pin.safeArea)
        containerView.flex.layout()
        scrollView.pin
            .top()
            .bottom(completeButton.frame.height + 12)
            .left()
            .right()
        scrollView.contentSize = contentView.frame.size
    }

    // MARK: - configure

    private func configureView() {
        backgroundColor = .background
    }

    private func configureSubView(konkukInfo: KonkukInfo) {
        addSubview(containerView)
        scrollView.addSubview(contentView)
        print(konkukInfo)
        configureInfoImageView(imageName: konkukInfo.imageURL)
        configureImageReferenceLabel(imageReference: konkukInfo.imageReference)

        configureTitleLabel(title: konkukInfo.title)
        configureDescriptionLabel(description: konkukInfo.description)
        configureCompleteButton()
    }

    private func configureInfoImageView(imageName: String) {
        print(imageName)
        if !imageName.isEmpty, let image = UIImage(named: imageName) {
            infoImageView.contentMode = .scaleAspectFit
            infoImageView.backgroundColor = .black
            infoImageView.image = image
        }
    }

    private func configureImageReferenceLabel(imageReference: String) {
        if !imageReference.isEmpty {
            imageReferenceLabel.text = "출처".localized + " :" + imageReference
            imageReferenceLabel.font = .caption1
            imageReferenceLabel.textColor = .white
            imageReferenceLabel.backgroundColor = .systemGray5
            imageReferenceLabel.layer.opacity = 1.0
        }
    }

    private func configureTitleLabel(title: String) {
        titleLabel.font = .title1
        titleLabel.textColor = .dynamicBlack
        titleLabel.text = title
        titleLabel.numberOfLines = 2
    }

    private func configureDescriptionLabel(description: String) {
        descriptionLabel.font = .body
        descriptionLabel.textColor = .dynamicBlack
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.lineBreakStrategy = .hangulWordPriority
        descriptionLabel.text = description
    }

    private func configureCompleteButton() {
        completeButton.updateTitleColor(color: .white)
    }

    private func configureFlexLayout() {
        contentView.flex.paddingHorizontal(16).define { flex in

            if hasImage {
                flex.addItem().marginHorizontal(30).define { flex in
                    flex.addItem(infoImageView).aspectRatio(1)
                    flex.addItem(imageReferenceLabel).height(20)
                    imageReferenceLabel.flex.position(.absolute).bottom(0).left(0).right(0)
                }
                .marginTop(12)
            }

            flex.addItem(titleLabel).marginTop(24)
            flex.addItem(descriptionLabel).marginTop(12).marginBottom(12)
        }

        containerView.flex.define { flex in
            flex.addItem(scrollView)
            flex.addItem(completeButton)
        }

        completeButton.flex.position(.absolute).left(16).right(16).bottom(10)
    }
}

extension KonkukInfoDetailView {
    func completeButtonPublisher() -> AnyPublisher<Void, Never> {
        return completeButton.tapPublisher
    }
}
