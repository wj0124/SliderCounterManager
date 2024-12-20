//
//  ViewController.swift
//  SliderCounterManagerDemo
//
//  Created by 王杰 on 2024/12/20.
/*
 .symbolEffect(.bounce)
 */


import UIKit
import SnapKit

class ViewController: UIViewController {

    // MARK: - 属性
    private lazy var counterManager = SliderCounterManager(maxValue: 20, interval: 0.3)
    private let counterView = StepControlView()

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
        view.addSubview(counterView)
        counterView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - 事件绑定
    private func setupActions() {
        counterView.toggleButton.addTarget(self, action: #selector(toggleAnimation), for: .touchUpInside)
        counterView.resetButton.addTarget(self, action: #selector(resetAnimation), for: .touchUpInside)
        counterView.slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        counterView.prevButton.addTarget(self, action: #selector(prevButtonTapped), for: .touchUpInside)
        counterView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }

    // MARK: - 事件处理
    @objc private func toggleAnimation() {
        switch counterManager.state {
        case .stopped, .paused:
            counterManager.start()
            counterView.toggleButton.setImage(.sf_pause, for: .normal)
        case .running:
            counterManager.pause()
            counterView.toggleButton.setImage(.sf_play, for: .normal)
        }
    }

    @objc private func resetAnimation() {
        counterManager.stop()
        counterView.toggleButton.setImage(.sf_play, for: .normal)
    }

    @objc private func sliderValueChanged(_ sender: UISlider) {
        counterManager.pause()
        counterView.toggleButton.setImage(.sf_play, for: .normal)
        counterManager.updateValueManually(to: sender.value)
    }

    @objc private func prevButtonTapped() {
        let currentValue = counterView.slider.value
        let prevValue = max(currentValue - 1, counterView.slider.minimumValue)
        updateSliderValue(to: prevValue)
    }

    @objc private func nextButtonTapped() {
        let currentValue = counterView.slider.value
        let nextValue = min(currentValue + 1, counterView.slider.maximumValue)
        updateSliderValue(to: nextValue)
    }

    private func updateSliderValue(to value: Float) {
        counterManager.pause()
        counterView.toggleButton.setImage(.sf_play, for: .normal)
        counterView.slider.setValue(value, animated: true)
        counterView.infoLabel.text = "次数: \(Int(value))"
        counterManager.updateValueManually(to: value)
    }
}

// MARK: - SliderCounterManagerDelegate 扩展
extension ViewController: SliderCounterManagerDelegate {
    func counterManager(didUpdateValue value: Float) {
        counterView.slider.value = value
        counterView.infoLabel.text = "次数: \(Int(value))"
    }

    func counterManager(didChangeState state: SliderCounterManager.State) {
        switch state {
        case .running:
            counterView.stateLabel.text = "当前状态: 运行中"
        case .paused:
            counterView.stateLabel.text = "当前状态: 已暂停"
        case .stopped:
            counterView.stateLabel.text = "当前状态: 已停止"
        }
    }
}
