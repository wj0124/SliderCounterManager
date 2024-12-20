//
//  Untitled.swift
//  SliderCounterManagerDemo
//
//  Created by 王杰 on 2024/12/20.
//
import UIKit
import SnapKit

class StepControlView: UIView {

    // MARK: - UI 元素
    let slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 20
        slider.value = 0
        return slider
    }()

    let toggleButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .red
        button.setImage(UIImage.sf_play, for: .normal)
        return button
    }()

    let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .systemRed
        button.setImage(UIImage(systemName: "arrow.clockwise", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)), for: .normal)
        return button
    }()

    let prevButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .red
        button.setImage(.sf_backward, for: .normal)
        return button
    }()

    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .red
        button.setImage(.sf_forward, for: .normal)
        return button
    }()

    let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "次数: 0"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        return label
    }()

    let stateLabel: UILabel = {
        let label = UILabel()
        label.text = "当前状态: 已停止"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .darkGray
        return label
    }()

    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI 设置
    private func setupUI() {
        addSubview(toggleButton)
        addSubview(slider)
        addSubview(prevButton)
        addSubview(resetButton)
        addSubview(nextButton)
        addSubview(infoLabel)
        addSubview(stateLabel)

        // 布局子视图
        toggleButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(50)
        }

        slider.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(toggleButton.snp.right).offset(10)
            make.right.equalToSuperview().offset(-20)
        }

        prevButton.snp.makeConstraints { make in
            make.top.equalTo(slider.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(50)
        }

        resetButton.snp.makeConstraints { make in
            make.top.equalTo(slider.snp.bottom).offset(20)
            make.left.equalTo(prevButton.snp.right).offset(20)
            make.width.height.equalTo(50)
        }

        nextButton.snp.makeConstraints { make in
            make.top.equalTo(slider.snp.bottom).offset(20)
            make.left.equalTo(resetButton.snp.right).offset(20)
            make.width.height.equalTo(50)
        }

        infoLabel.snp.makeConstraints { make in
            make.bottom.equalTo(slider.snp.top).offset(-20)
            make.centerX.equalToSuperview()
        }

        stateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(infoLabel.snp.top).offset(-10)
            make.centerX.equalToSuperview()
        }
    }
}
