//
//  Commnunity.swift
//  Demo
//
//  Created by abiaoyo on 2025/3/12.
//

import UIKit
import SnapKit
import Then
struct Community{
    
}

extension Community {
    
    class RolllingBatchView: LUCornersViewSwift, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
        protocol Delegate: AnyObject{
//            func rollingBatchViewForTitle() -> String
//            func rollingBatchViewForDatas() -> [RowDataProtocol]
            func rollingBatchViewDidClick(index:Int, data:RowDataProtocol)
        }
        
        protocol RowDataProtocol {
            var icon:String { get }
            var title:String { get }
            var numIcon:String { get }
            var num:Int { get }
        }
        
        fileprivate class RowCell:UICollectionViewCell {
            override init(frame: CGRect) {
                super.init(frame: frame)
                setupSubviews()
                setupLayout()
            }
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            lazy var iconImageView = UIImageView().then { v in
                v.backgroundColor = .random
            }
            lazy var titleLabel = UILabel().then { v in
                v.numberOfLines = 0
                v.font = UIFont.systemFont(ofSize: 13)
                v.text = "Govee light Festival"
            }
            lazy var numIconImageView = UIImageView().then { v in
                v.backgroundColor = .random
            }
            lazy var numLabel = UILabel().then { v in
                v.numberOfLines = 0
                v.font = UIFont.systemFont(ofSize: 12)
                v.text = "123"
            }
            func setupSubviews() {
                addSubview(iconImageView)
                addSubview(titleLabel)
                addSubview(numIconImageView)
                addSubview(numLabel)
            }
            func setupLayout() {
                iconImageView.snp.makeConstraints { make in
                    make.size.equalTo(CGSize(width: 18.5.rate, height: 18.5.rate))
                    make.centerY.equalToSuperview()
                    make.leading.equalToSuperview()
                }
                titleLabel.snp.makeConstraints { make in
                    make.leading.equalTo(iconImageView.snp.trailing).offset(3.5)
                    make.height.equalTo(18.5.rate)
                    make.centerY.equalTo(iconImageView)
                }
                numIconImageView.snp.makeConstraints { make in
                    make.size.equalTo(CGSize(width: 13.rate, height: 13.rate))
                    make.centerY.equalTo(iconImageView)
                    make.trailing.equalTo(numLabel.snp.leading).offset(-3.5)
                }
                numLabel.snp.makeConstraints { make in
                    make.trailing.equalToSuperview()
                    make.height.equalTo(18.5.rate)
                    make.centerY.equalTo(iconImageView)
                }
            }
            func config(data: RowDataProtocol) {
//                iconImageView.image(named: data.icon)
//                numIconImageView.image(named: data.numIcon)
                titleLabel.text = data.title
                numLabel.text = "\(data.num)"
            }
        }
        
        fileprivate class TopView: LUFastViewSwift {
            class RefreshButton: LUFastControlSwift {
                lazy var iconImageView = UIImageView().then { v in
//                    v.image(named: "community_icon_shuaxin")
                    v.backgroundColor = .random
                }
                lazy var titleLabel = UILabel().then { v in
                    v.font = UIFont.systemFont(ofSize: 11)
                    v.text = "换一批"
                    v.numberOfLines = 0
                }
                override func setupSubviews() {
                    addSubview(iconImageView)
                    addSubview(titleLabel)
                }
                override func setupLayout() {
                    iconImageView.snp.makeConstraints { make in
                        make.size.equalTo(CGSize(width: 13, height: 13))
                        make.leading.centerY.equalToSuperview()
                    }
                    titleLabel.snp.makeConstraints { make in
                        make.leading.equalTo(iconImageView.snp.trailing).offset(4)
                        make.top.bottom.trailing.equalToSuperview()
                    }
                }
            }
            lazy var titleLabel = UILabel().then { v in
                v.numberOfLines = 0
                v.font = UIFont.systemFont(ofSize: 14, weight: .medium)
                v.text = "滚动视图标题"
            }
            lazy var refreshButton = RefreshButton().then { v in
                v.backgroundColor = .random
            }
            override func setupSubviews() {
                addSubview(titleLabel)
                addSubview(refreshButton)
            }
            override func setupLayout() {
                titleLabel.snp.makeConstraints { make in
                    make.top.bottom.equalToSuperview()
                    make.leading.equalToSuperview().inset(15.rate).priority(.required)
                    make.trailing.equalTo(refreshButton.snp.leading).offset(-5)
                }
                refreshButton.snp.makeConstraints { make in
                    make.trailing.equalToSuperview().inset(15.rate).priority(.required)
                    make.height.equalTo(40.rate)
                    make.centerY.equalToSuperview()
                }
                titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
                titleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
                refreshButton.setContentHuggingPriority(.required, for: .horizontal)
                refreshButton.setContentCompressionResistancePriority(.required, for: .horizontal)
            }
        }
        
        fileprivate class BottomView: LUCornersViewSwift {
            lazy var collectionView: UICollectionView = {
                let layout = UICollectionViewFlowLayout()
                layout.minimumLineSpacing = 12.rate
                layout.minimumInteritemSpacing = 0
                layout.scrollDirection = .vertical
                
                let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
                v.backgroundColor = .clear
                v.contentInset = .zero
                v.contentInsetAdjustmentBehavior = .never
                v.register(RowCell.self, forCellWithReuseIdentifier: "cell")
                v.isScrollEnabled = false
                return v
            }()
            override func setupSubviews() {
                addSubview(collectionView)
            }
            override func setupLayout() {
                collectionView.snp.makeConstraints { make in
                    make.top.leading.trailing.bottom.equalToSuperview().inset(12.rate)
                }
            }
        }
        
        fileprivate lazy var topView = TopView().then { v in
            v.backgroundColor = .random
        }
        fileprivate lazy var bottomView = BottomView().then { v in
            v.backgroundColor = .random
            v.layer.masksToBounds = true
            v.layer.cornerRadius = 10
            v.collectionView.delegate = self
            v.collectionView.dataSource = self
        }
        
        override func setupSubviews() {
            super.setupSubviews()
            layer.masksToBounds = true
            layer.cornerRadius = 10
            addSubview(topView)
            addSubview(bottomView)
        }
        override func setupLayout() {
            super.setupLayout()
            topView.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(40.rate)
            }
            bottomView.snp.makeConstraints { make in
                make.top.equalTo(40.rate).priority(.high)
                make.leading.trailing.equalToSuperview().inset(2.5.rate)
                make.bottom.equalToSuperview().inset(2.5.rate).priority(.low)
                make.height.equalTo(103.5.rate).priority(.required)
            }
        }
        var heightConstraint: SnapKit.Constraint?
        fileprivate lazy var datas:[RowDataProtocol] = []
        weak var delegate:Delegate?
        
        override func layoutSubviews() {
            super.layoutSubviews()
        }
        
        func config(datas:[RowDataProtocol]) {
            self.datas = datas
            let bottomHeight = CGFloat(datas.count) * 18.5.rate + CGFloat(datas.count + 1) * 12.rate
            bottomView.snp.updateConstraints { make in
                make.height.equalTo(bottomHeight).priority(.required)
            }
            DispatchQueue.main.async {
                self.bottomView.collectionView.reloadData()
            }
        }
        
        //MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            datas.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let data = datas[indexPath.item]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RowCell
            cell.config(data: data)
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            collectionView.deselectItem(at: indexPath, animated: true)
            let data = datas[indexPath.item]
            delegate?.rollingBatchViewDidClick(index: indexPath.item, data: data)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = collectionView.bounds.width
            let height = 18.5.rate
            return CGSize(width: width, height: height)
        }
        
    }
    
}
