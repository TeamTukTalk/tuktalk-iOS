//
//  PortfolioPreviceTVCell.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/12/02.
//

import RxSwift

class PortfolioPreviewTVCell: UITableViewCell {
    
    public static let identifier : String = "PortfolioPreviceTVCell"
    private let disposeBag = DisposeBag()
    private let imageData = BehaviorSubject<[UIImage]>(value: [])
    private var dataList: [UIImage] = []
    
    private let titleLabel = UILabel().then {
        $0.text = "포트폴리오 미리보기 👀"
        $0.font = UIFont.TTFont(type: .SDBold, size: 14)
        $0.textColor = UIColor.GrayScale.normal
    }
    
    var previewCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setColectionView()
        bindingCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(urlString: [String]) {
        if urlString.count > 0 {
            for s in urlString {
                let url = URL(string: s)
                guard let url = url else { return }
                let data = try? Data(contentsOf: url)
                dataList.append(UIImage(data: data ?? Data()) ?? UIImage())
            }
            imageData.onNext(dataList)
        }
    }
    
    private func setUI() {
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.leading.equalToSuperview()
        }
        
        contentView.addSubview(previewCV)
        previewCV.snp.makeConstraints {
            $0.height.equalTo(180)
            $0.width.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.bottom.equalToSuperview().inset(32)
        }
    }
    
    private func setColectionView() {
        previewCV.rx.setDelegate(self).disposed(by: disposeBag)
        
        let layout: UICollectionViewFlowLayout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.scrollDirection = .horizontal
        previewCV.setCollectionViewLayout(layout, animated: false)
        previewCV.backgroundColor = .white
        previewCV.showsHorizontalScrollIndicator = false
        previewCV.register(PortfolioPreviewCVCell.self, forCellWithReuseIdentifier: "PortfolioPreviewCVCell")
    }
    
    private func bindingCollectionView() {
        imageData
            .bind(to: previewCV.rx.items) { (cv, row, item) -> UICollectionViewCell in
                if let cell = self.previewCV.dequeueReusableCell(withReuseIdentifier: "PortfolioPreviewCVCell", for: IndexPath.init(row: row, section: 0)) as? PortfolioPreviewCVCell {
                    cell.setData(img: item)
                    return cell
                }
                return UICollectionViewCell()
            }
            .disposed(by: disposeBag)
    }
}

extension PortfolioPreviewTVCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 320, height: 180)
    }
}
