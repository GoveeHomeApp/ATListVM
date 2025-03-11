//
//  ATListVM.swift
//  ATMVVMDemo
//
//  Created by abiaoyo on 2025/3/11.
//

import UIKit

open class ATListCell: UICollectionViewCell {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupData()
        setupSubviews()
        setupLayout()
    }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupData() {}
    open func setupSubviews() {}
    open func setupLayout() {}
    
    public private(set) var itemVM: ATListItemVM?
    public private(set) var indexPath:IndexPath?
    
    final func config(itemVM: ATListItemVM, indexPath:IndexPath) {
        self.indexPath = indexPath
        configAndRefresh(itemVM: itemVM)
    }
    private func configAndRefresh(itemVM: ATListItemVM) {
        self.itemVM = itemVM
        refreshSubviews(isFromVM: false)
        layoutIfNeeded()
    }
    open func refreshSubviews(isFromVM:Bool) {
        
    }
}

open class ATListItemVM {
    
    public typealias ReloadSectionBlock = (() -> Void)
    public typealias RefreshItemBlock = (() -> Void)
    public typealias ReloadListBlock = (() -> Void)
    public typealias SelectItemBlock = ((_ collectionView:UICollectionView, _ indexPath:IndexPath, _ itemVM: ATListItemVM) -> Void)
    
    public fileprivate(set) var reloadSectionBlock:ReloadSectionBlock?
    public fileprivate(set) var refreshItemBlock:RefreshItemBlock?
    public fileprivate(set) var reloadListBlock:ReloadListBlock?
    public var onSelectItemBlock:SelectItemBlock?
    
    public fileprivate(set) weak var collectionView: UICollectionView?
    public fileprivate(set) var indexPath: IndexPath?
    
    public var cellId:String = "UICollectionViewCell"
    
    public init() {
        _setupBlock()
        setupData()
    }
    func _setupBlock() {
        reloadSectionBlock = { [weak self] in
            guard let self = self else { return }
            let section = self.indexPath?.section ?? 0
            DispatchQueue.main.async {
                UIView.performWithoutAnimation {
                    self.collectionView?.reloadSections(IndexSet(integer: section))
                }
            }
        }
        reloadListBlock = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                UIView.performWithoutAnimation {
                    self.collectionView?.reloadData()
                }
            }
        }
        refreshItemBlock = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                guard let collectionView = self.collectionView, let indexPath = self.indexPath else { return }
                UIView.performWithoutAnimation {
                    if let cell = collectionView.cellForItem(at: indexPath) as? ATListCell {
                        cell.refreshSubviews(isFromVM: true)
                        cell.layoutIfNeeded()
                    }
                }
            }
        }
    }
    open func setupData() {
        
    }
    open func createLayout() {
        
    }
}


open class ATListReuseableView: UICollectionReusableView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupData()
        setupSubviews()
        setupLayout()
    }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupData() {}
    open func setupSubviews() {}
    open func setupLayout() {}
    
    public private(set) var sectionVM: ATListSectionVM?
    public private(set) var indexPath:IndexPath?
    
    final func config(sectionVM: ATListSectionVM, indexPath:IndexPath) {
        self.indexPath = indexPath
        configAndRefresh(sectionVM: sectionVM)
    }
    private func configAndRefresh(sectionVM: ATListSectionVM) {
        self.sectionVM = sectionVM
        refreshSubviews(isFromVM: false)
        layoutIfNeeded()
    }
    open func refreshSubviews(isFromVM:Bool) {
        
    }
}

open class ATListSectionVM {
    public typealias ReloadSectionBlock = (() -> Void)
    public typealias ReloadListBlock = (() -> Void)
    public typealias RefreshHeaderBlock = (() -> Void)
    public typealias RefreshFooterBlock = (() -> Void)
    
    public fileprivate(set) var reloadSectionBlock:ReloadSectionBlock?
    public fileprivate(set) var reloadListBlock:ReloadListBlock?
    public fileprivate(set) var refreshHeaderBlock:RefreshHeaderBlock?
    public fileprivate(set) var refreshFooterBlock:RefreshFooterBlock?
    
    public fileprivate(set) weak var collectionView: UICollectionView?
    public fileprivate(set) var indexPath: IndexPath?
    
    public var headerId:String?
    public var footerId:String?
    public var layoutSection:NSCollectionLayoutSection?
    
    public var itemVMs:[ATListItemVM] = []
    
    public init() {
        _setupBlock()
        setupData()
    }
    func _setupBlock() {
        reloadSectionBlock = { [weak self] in
            guard let self = self else { return }
            let section = self.indexPath?.section ?? 0
            DispatchQueue.main.async {
                UIView.performWithoutAnimation {
                    self.collectionView?.reloadSections(IndexSet(integer: section))
                }
            }
        }
        reloadListBlock = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                UIView.performWithoutAnimation {
                    self.collectionView?.reloadData()
                }
            }
        }
        refreshHeaderBlock = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                guard let collectionView = self.collectionView, let indexPath = self.indexPath else { return }
                UIView.performWithoutAnimation {
                    if let header = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: indexPath) as? ATListReuseableView {
                        header.refreshSubviews(isFromVM: true)
                        header.layoutIfNeeded()
                    }
                }
            }
        }
        refreshHeaderBlock = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                guard let collectionView = self.collectionView, let indexPath = self.indexPath else { return }
                UIView.performWithoutAnimation {
                    if let footer = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionFooter, at: indexPath) as? ATListReuseableView {
                        footer.refreshSubviews(isFromVM: true)
                        footer.layoutIfNeeded()
                    }
                }
            }
        }
    }
    open func setupData() {
        
    }
    open func createLayout() {
        
    }
}

final public class ATListViewProxy: NSObject {
    public weak var forwarder:AnyObject?
    private var _defaultSectionVM:ATListSectionVM?
    public var defaultSectionVM:ATListSectionVM {
        get {
            if let vm = _defaultSectionVM {
                return vm
            }
            let vm = ATListSectionVM()
            _defaultSectionVM = vm
            return vm
        }
        set {
            _defaultSectionVM = newValue
        }
    }
    public lazy var sectionVMs:[ATListSectionVM] = []
    
    private func getSectionVM(section:Int) -> ATListSectionVM? {
        if _defaultSectionVM == nil {
            if section < sectionVMs.count {
                return sectionVMs[section]
            }
        }
        return _defaultSectionVM
    }
    private func getItemVM(section: Int, item:Int) -> ATListItemVM? {
        if let sectionVM = getSectionVM(section: section) {
            if item < sectionVM.itemVMs.count {
                return sectionVM.itemVMs[item]
            }
        }
        return nil
    }
    private func getItemVM(indexPath: IndexPath) -> ATListItemVM? {
        getItemVM(section: indexPath.section, item: indexPath.item)
    }
    public override func forwardingTarget(for aSelector: Selector!) -> Any? {
        if let forwarder = forwarder, forwarder.responds(to: aSelector) {
            return forwarder
        }
        return super.forwardingTarget(for: aSelector)
    }
    public override func responds(to aSelector: Selector!) -> Bool {
        super.responds(to: aSelector) || (forwarder != nil && forwarder!.responds(to: aSelector))
    }
}
extension ATListViewProxy: UICollectionViewDelegate, UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        if _defaultSectionVM == nil {
            return sectionVMs.count
        }
        return 1
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        getSectionVM(section: section)?.itemVMs.count ?? 0
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionVM = getSectionVM(section: indexPath.section)
        sectionVM?.indexPath = indexPath
        sectionVM?.collectionView = collectionView
        
        guard let itemVM = getItemVM(indexPath: indexPath) else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
            return cell
        }
        itemVM.indexPath = indexPath
        itemVM.collectionView = collectionView
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemVM.cellId, for: indexPath) as! ATListCell
        cell.config(itemVM: itemVM, indexPath: indexPath)
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let sectionVM = getSectionVM(section: indexPath.section) else {
            return UICollectionReusableView()
        }
        if kind == UICollectionView.elementKindSectionHeader {
            if let headerId = sectionVM.headerId {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! ATListReuseableView
                header.config(sectionVM: sectionVM, indexPath: indexPath)
                return header
            }
        }else if kind == UICollectionView.elementKindSectionFooter {
            if let footerId = sectionVM.footerId {
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath) as! ATListReuseableView
                footer.config(sectionVM: sectionVM, indexPath: indexPath)
                return footer
            }
        }
        return UICollectionReusableView()
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let itemVM = getItemVM(indexPath: indexPath) else { return }
        itemVM.onSelectItemBlock?(collectionView, indexPath, itemVM)
    }
}

open class ATListVM {
    
    public private(set) var viewProxy:ATListViewProxy = ATListViewProxy()
    fileprivate weak var collecitonView:UICollectionView?
    
    public init() {
        setupData()
    }
    
    public init(viewProxy:ATListViewProxy) {
        self.viewProxy = viewProxy
        setupData()
    }
    
    open func setupData() {
        
    }
    
    open func createData() {
        
    }
    
    open func reloadData() {
        collecitonView?.reloadData()
    }
    
    open func register(collectionView: UICollectionView) {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        self.collecitonView = collectionView
    }
}

extension UICollectionView {
    public func config(listVM: ATListVM) {
        listVM.register(collectionView: self)
    }
    
    public func config(viewProxy:ATListViewProxy) {
        delegate = viewProxy
        dataSource = viewProxy
        register(ATListReuseableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ATListReuseableView")
        register(ATListReuseableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "ATListReuseableView")
    }
}
