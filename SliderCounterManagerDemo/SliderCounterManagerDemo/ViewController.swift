//
//  ViewController.swift
//  SliderCounterManagerDemo
//
//  Created by 王杰 on 2024/12/20.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    // MARK: - UI 元素

    private let slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 20
        slider.value = 0
        return slider
    }()

    private let toggleButton: UIButton = {
        let button = UIButton(type: .system)
        let configuration = UIImage.SymbolConfiguration(pointSize: 40, weight: .medium)
        button.setImage(UIImage(systemName: "play.fill", withConfiguration: configuration), for: .normal)
        button.setImage(UIImage(systemName: "pause.fill", withConfiguration: configuration), for: .selected)
        button.tintColor = .systemBlue
        return button
    }()

    private let resetButton: UIButton = {
        let button = UIButton(type: .system)
        let configuration = UIImage.SymbolConfiguration(pointSize: 40, weight: .medium)
        button.setImage(UIImage(systemName: "arrow.clockwise", withConfiguration: configuration), for: .normal)
        button.tintColor = .systemRed
        return button
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "次数: 0"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        return label
    }()

    private let stateLabel: UILabel = {
        let label = UILabel()
        label.text = "当前状态: 已停止"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .darkGray
        return label
    }()

    // MARK: - 属性

    private lazy var counterManager = SliderCounterManager(maxValue: 20, interval: 0.3)

    // MARK: - 生命周期

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        counterManager.delegate = self
    }

    // MARK: - UI 设置

    private func setupUI() {
        view.backgroundColor = .white

        // 添加子视图
        view.addSubview(slider)
        view.addSubview(toggleButton)
        view.addSubview(resetButton)
        view.addSubview(infoLabel)
        view.addSubview(stateLabel)

        // 布局子视图
        slider.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(300)
        }

        toggleButton.snp.makeConstraints { make in
            make.top.equalTo(slider.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(80)
            make.width.height.equalTo(50)
        }

        resetButton.snp.makeConstraints { make in
            make.top.equalTo(slider.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-80)
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

    // MARK: - 按钮和滑块事件

    private func setupActions() {
        toggleButton.addTarget(self, action: #selector(toggleAnimation), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetAnimation), for: .touchUpInside)
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
    }

    @objc private func toggleAnimation() {
        switch counterManager.state {
        case .stopped, .paused:
            counterManager.start()
            toggleButton.isSelected = true
        case .running:
            counterManager.pause()
            toggleButton.isSelected = false
        }
    }

    @objc private func resetAnimation() {
        counterManager.stop()
        toggleButton.isSelected = false
    }

    @objc private func sliderValueChanged(_ sender: UISlider) {
        counterManager.pause()
        toggleButton.isSelected = false
        counterManager.updateValueManually(to: sender.value)
    }
}

// MARK: - SliderCounterManagerDelegate 扩展

extension ViewController: SliderCounterManagerDelegate {
    func counterManager(didUpdateValue value: Float) {
        slider.value = value
        infoLabel.text = "次数: \(Int(value))"
    }

    func counterManager(didChangeState state: SliderCounterManager.State) {
        switch state {
        case .running:
            stateLabel.text = "当前状态: 运行中"
        case .paused:
            stateLabel.text = "当前状态: 已暂停"
        case .stopped:
            stateLabel.text = "当前状态: 已停止"
        }
    }
}


protocol SliderCounterManagerDelegate: AnyObject {
    func counterManager(didUpdateValue value: Float)
    func counterManager(didChangeState state: SliderCounterManager.State)
}

class SliderCounterManager {
    enum State {
        case running
        case paused
        case stopped
    }

    weak var delegate: SliderCounterManagerDelegate?

    private var timer: Timer?
    private var currentValue: Float = 0
    private let maxValue: Float
    private let interval: TimeInterval

    private(set) var state: State = .stopped {
        didSet {
            delegate?.counterManager(didChangeState: state)
        }
    }

    init(maxValue: Float, interval: TimeInterval) {
        self.maxValue = maxValue
        self.interval = interval
    }

    func start() {
        guard state != .running else { return }
        state = .running
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(updateValue), userInfo: nil, repeats: true)
    }

    func pause() {
        guard state == .running else { return }
        state = .paused
        timer?.invalidate()
    }

    func stop() {
        state = .stopped
        timer?.invalidate()
        currentValue = 0
        delegate?.counterManager(didUpdateValue: currentValue)
    }

    func updateValueManually(to value: Float) {
        currentValue = min(value, maxValue)
        delegate?.counterManager(didUpdateValue: currentValue)
    }

    @objc private func updateValue() {
        currentValue += 1
        if currentValue > maxValue {
            currentValue = 0
        }
        delegate?.counterManager(didUpdateValue: currentValue)
    }
}


