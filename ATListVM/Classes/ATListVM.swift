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
    open func willDisplay() {
        
    }
    open func didEndDisplaying() {
        
    }
    open func refreshSubviews(isFromVM:Bool) {
        
    }
}

open class ATListItemVM {
    
    public typealias ReloadBlock = (() -> Void)
    public typealias RefreshBlock = (() -> Void)
    public typealias SelectItemBlock = ((_ collectionView:UICollectionView, _ indexPath:IndexPath, _ itemVM: ATListItemVM) -> Void)
    
    public fileprivate(set) var reloadListBlock:ReloadBlock?
    public fileprivate(set) var reloadSectionBlock:ReloadBlock?
    public fileprivate(set) var reloadItemBlock:ReloadBlock?
    public fileprivate(set) var refreshItemBlock:RefreshBlock?
    public var onSelectItemBlock:SelectItemBlock?
    
    public fileprivate(set) weak var collectionView: UICollectionView?
    public fileprivate(set) var indexPath: IndexPath?
    
    public var cellId:String = "UICollectionViewCell"
    public var itemSize:CGSize = .zero
    public var data:Any?
    
    public init() {
        _setupBlock()
        setupData()
    }
    func _setupBlock() {
        reloadListBlock = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                UIView.performWithoutAnimation {
                    self.collectionView?.reloadData()
                }
            }
        }
        reloadSectionBlock = { [weak self] in
            guard let self = self else { return }
            let section = self.indexPath?.section ?? 0
            DispatchQueue.main.async {
                UIView.performWithoutAnimation {
                    self.collectionView?.reloadSections(IndexSet(integer: section))
                }
            }
        }
        reloadItemBlock = { [weak self] in
            guard let self = self else { return }
            guard let indexPath = self.indexPath else { return }
            DispatchQueue.main.async {
                UIView.performWithoutAnimation {
                    self.collectionView?.reloadItems(at: [indexPath])
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
    open func willDisplay() {
        
    }
    open func didEndDisplaying() {
        
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
    public typealias ReloadBlock = (() -> Void)
    public typealias RefreshBlock = (() -> Void)
    
    public fileprivate(set) var reloadListBlock:ReloadBlock?
    public fileprivate(set) var reloadSectionBlock:ReloadBlock?
    public fileprivate(set) var refreshHeaderBlock:RefreshBlock?
    public fileprivate(set) var refreshFooterBlock:RefreshBlock?
    
    public fileprivate(set) weak var collectionView: UICollectionView?
    public fileprivate(set) var indexPath: IndexPath?
    
    public var headerId:String?
    public var footerId:String?
    public var layoutSection:NSCollectionLayoutSection?
    public var headerSize:CGSize = .zero
    public var footerSize:CGSize = .zero
    public var sectionInset:UIEdgeInsets = .zero
    public var minimumLineSpacing:CGFloat = 0
    public var minimumInteritemSpacing:CGFloat = 0
    public var itemVMs:[ATListItemVM] = []
    
    public init() {
        _setupBlock()
        setupData()
    }
    func _setupBlock() {
        reloadListBlock = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                UIView.performWithoutAnimation {
                    self.collectionView?.reloadData()
                }
            }
        }
        reloadSectionBlock = { [weak self] in
            guard let self = self else { return }
            let section = self.indexPath?.section ?? 0
            DispatchQueue.main.async {
                UIView.performWithoutAnimation {
                    self.collectionView?.reloadSections(IndexSet(integer: section))
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
        refreshFooterBlock = { [weak self] in
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

public protocol ATListViewProxyDelegate: AnyObject {
    func listViewProxy(collectionView: UICollectionView, cell:UICollectionViewCell, indexPath:IndexPath)
    func listViewProxy(collectionView: UICollectionView, cellWillDisplay:UICollectionViewCell, indexPath:IndexPath)
    func listViewProxy(collectionView: UICollectionView, cellDidEndDisplaying:UICollectionViewCell, indexPath:IndexPath)
    func listViewProxy(collectionView: UICollectionView, header:UICollectionReusableView, kind:String, indexPath:IndexPath)
    func listViewProxy(collectionView: UICollectionView, footer:UICollectionReusableView, kind:String, indexPath:IndexPath)
}

extension ATListViewProxyDelegate {
    public func listViewProxy(collectionView: UICollectionView, cell:UICollectionViewCell, indexPath:IndexPath) {}
    public func listViewProxy(collectionView: UICollectionView, cellWillDisplay:UICollectionViewCell, indexPath:IndexPath) {}
    public func listViewProxy(collectionView: UICollectionView, cellDidEndDisplaying:UICollectionViewCell, indexPath:IndexPath) {}
    public func listViewProxy(collectionView: UICollectionView, header:UICollectionReusableView, kind:String, indexPath:IndexPath) {}
    public func listViewProxy(collectionView: UICollectionView, footer:UICollectionReusableView, kind:String, indexPath:IndexPath) {}
}

open class ATListViewProxy: NSObject {
    public weak var forwarder:AnyObject?
    public weak var delegate:ATListViewProxyDelegate?
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
extension ATListViewProxy: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        if _defaultSectionVM == nil {
            return sectionVMs.count
        }
        return 1
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionVM = getSectionVM(section: section)
        sectionVM?.collectionView = collectionView
        return sectionVM?.itemVMs.count ?? 0
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionVM = getSectionVM(section: indexPath.section)
        sectionVM?.indexPath = indexPath
        
        guard let itemVM = getItemVM(indexPath: indexPath) else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
            self.delegate?.listViewProxy(collectionView: collectionView, cell: cell, indexPath: indexPath)
            return cell
        }
        itemVM.indexPath = indexPath
        itemVM.collectionView = collectionView
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemVM.cellId, for: indexPath) as? ATListCell {
            cell.config(itemVM: itemVM, indexPath: indexPath)
            self.delegate?.listViewProxy(collectionView: collectionView, cell: cell, indexPath: indexPath)
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        self.delegate?.listViewProxy(collectionView: collectionView, cell: cell, indexPath: indexPath)
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let itemVM = getItemVM(indexPath: indexPath)
        itemVM?.willDisplay()
        if let listCell = cell as? ATListCell {
            listCell.willDisplay()
        }
        self.delegate?.listViewProxy(collectionView: collectionView, cellWillDisplay: cell, indexPath: indexPath)
    }
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let itemVM = getItemVM(indexPath: indexPath)
        itemVM?.didEndDisplaying()
        if let listCell = cell as? ATListCell {
            listCell.didEndDisplaying()
        }
        self.delegate?.listViewProxy(collectionView: collectionView, cellDidEndDisplaying: cell, indexPath: indexPath)
    }
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let sectionVM = getSectionVM(section: indexPath.section) else {
            return UICollectionReusableView()
        }
        if kind == UICollectionView.elementKindSectionHeader {
            if let headerId = sectionVM.headerId {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! ATListReuseableView
                header.config(sectionVM: sectionVM, indexPath: indexPath)
                self.delegate?.listViewProxy(collectionView: collectionView, header: header, kind: kind, indexPath: indexPath)
                return header
            }
        }else if kind == UICollectionView.elementKindSectionFooter {
            if let footerId = sectionVM.footerId {
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath) as! ATListReuseableView
                footer.config(sectionVM: sectionVM, indexPath: indexPath)
                self.delegate?.listViewProxy(collectionView: collectionView, footer: footer, kind: kind, indexPath: indexPath)
                return footer
            }
        }
        return UICollectionReusableView()
    }
}
extension ATListViewProxy: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let itemVM = getItemVM(indexPath: indexPath) else { return }
        itemVM.onSelectItemBlock?(collectionView, indexPath, itemVM)
    }
}

extension ATListViewProxy: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        getItemVM(indexPath: indexPath)?.itemSize ?? .zero
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        getSectionVM(section: section)?.headerSize ?? .zero
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        getSectionVM(section: section)?.footerSize ?? .zero
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        getSectionVM(section: section)?.sectionInset ?? .zero
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        getSectionVM(section: section)?.minimumLineSpacing ?? 0
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        getSectionVM(section: section)?.minimumInteritemSpacing ?? 0
    }
}

public enum ATListVMState {
    case idl
    case add
    case delete
    case update
    case query
    case success
    case failure
    case error
    case empty
    case noNet
    case noData
    case load
    case custom(Int)
}

public protocol ATListVMDelegate: AnyObject {
    func listVMDidChange(state:ATListVMState, tag:Int, msg:String?, err:Error?)
}

open class ATListVM: NSObject {
    
    public private(set) var viewProxy:ATListViewProxy = ATListViewProxy()
    fileprivate weak var collecitonView:UICollectionView?
    
    public weak var delegate:ATListVMDelegate?
    
    public override init() {
        super.init()
        setupData()
    }
    
    public init(viewProxy:ATListViewProxy) {
        super.init()
        self.viewProxy = viewProxy
        setupData()
    }
    
    open func setupData() {
        
    }
    
    open func createData() {
        
    }
    
    open func reloadData() {
        DispatchQueue.main.async {
            self.collecitonView?.reloadData()
        }
    }
    
    open func register(collectionView: UICollectionView) {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        self.collecitonView = collectionView
    }
    
}

extension ATListVM: ATListVMDelegate {
    public func listVMDidChange(state: ATListVMState, tag: Int, msg: String?, err: (any Error)?) {
        delegate?.listVMDidChange(state: state, tag: tag, msg: msg, err: err)
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
