//
//  HistoryViewController.swift
//  SourceDLT_App
//
//  Created by masato on 26/2/2020.
//  Copyright © 2020 Masato Miyai. All rights reserved.
//



import UIKit

class CustomWidthView: UIView {
    var width = 1.0

    override public var intrinsicContentSize: CGSize {
        return CGSize(width: width, height: 0)
    }
}


class CustomHeightView: UIView {
    var height = 1.0

    override public var intrinsicContentSize: CGSize {
        return CGSize(width: 0, height: height)
    }
}



// (4) セルのレイアウトを指定するクラスを作る
class HistoryCell: UICollectionViewCell {


    var userImageFromArray = UIImage()
    var userNameText = ""

    var receiptWatchImage = UIImage()
    var receiptTimeText = ""

    var receiptMarkImage = UIImage()
    var receiptText = ""

    var shipmentMarkImage = UIImage()
    var shipmentText = ""

    var shipmentTimeImage = UIImage()
    var shipmentTimeText = ""


    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
        setupViews()
    }

    let wordLabel: UILabel = {
        let label = UILabel()
        label.text = "TEST TEST TEST"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    func setupViews() {
        backgroundColor = .white

        //MARK: 1. Vertical Split View
        addSubview(wordLabel)
        wordLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        wordLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        wordLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        wordLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true


        let stackView = UIStackView(arrangedSubviews: [redView, greenView])

        stackView.axis = .horizontal
        stackView.spacing = 1

        stackView.distribution = .fillProportionally
        stackView.alignment = .fill

        stackView.isBaselineRelativeArrangement = false
        stackView.isLayoutMarginsRelativeArrangement = false


        stackView.subviews[0].widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 350 / 1000, constant: 0).isActive = true
        stackView.subviews[1].widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 650 / 1000, constant: 0).isActive = true


        wordLabel.addSubview(stackView)


        stackView.translatesAutoresizingMaskIntoConstraints  = false
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .zero)


        //MARK: 2. Horizontal Split Red View
        let horizontalStackView01 = UIStackView(arrangedSubviews: [userImage, userNameLabel])
        userImage.image = userImageFromArray
        userNameLabel.text = userNameText

        horizontalStackView01.axis = .vertical

        horizontalStackView01.distribution = .fillProportionally
        horizontalStackView01.alignment = .fill

        horizontalStackView01.isBaselineRelativeArrangement = false
        horizontalStackView01.isLayoutMarginsRelativeArrangement = false

        horizontalStackView01.subviews[0].heightAnchor.constraint(equalTo: horizontalStackView01.heightAnchor, multiplier: 650/1000, constant: 0).isActive = true
        horizontalStackView01.subviews[1].heightAnchor.constraint(equalTo: horizontalStackView01.heightAnchor, multiplier: 350/1000, constant: 0).isActive = true

        redView.addSubview(horizontalStackView01)
        horizontalStackView01.translatesAutoresizingMaskIntoConstraints  = false
        horizontalStackView01.anchor(top: redView.topAnchor, leading: redView.leadingAnchor, bottom: redView.bottomAnchor, trailing: redView.trailingAnchor, padding: .zero)


        //MARK: 3. Horizontal Split Red View
        let horizontalStackView02 = UIStackView(arrangedSubviews: [layoutView01, layoutView02, layoutView03, layoutView04])

        horizontalStackView02.axis = .vertical

        horizontalStackView02.distribution = .fillProportionally
        horizontalStackView02.alignment = .fill

        horizontalStackView02.isBaselineRelativeArrangement = false
        horizontalStackView02.isLayoutMarginsRelativeArrangement = false

        horizontalStackView02.subviews[0].heightAnchor.constraint(equalTo: horizontalStackView02.heightAnchor, multiplier: 1/4, constant: 0).isActive = true
        horizontalStackView02.subviews[1].heightAnchor.constraint(equalTo: horizontalStackView02.heightAnchor, multiplier: 1/4, constant: 0).isActive = true
        horizontalStackView02.subviews[2].heightAnchor.constraint(equalTo: horizontalStackView02.heightAnchor, multiplier: 1/4, constant: 0).isActive = true
        horizontalStackView02.subviews[3].heightAnchor.constraint(equalTo: horizontalStackView02.heightAnchor, multiplier: 1/4, constant: 0).isActive = true

        greenView.addSubview(horizontalStackView02)
        horizontalStackView02.translatesAutoresizingMaskIntoConstraints  = false
        horizontalStackView02.anchor(top: greenView.topAnchor, leading: greenView.leadingAnchor, bottom: greenView.bottomAnchor, trailing: greenView.trailingAnchor, padding: .zero)



        // --------------------------------
        //MARK: Layout
        // --------------------------------
        layoutView01.addSubview(imageView01)
        imageView01.image = receiptWatchImage
        imageView01.anchor(top: layoutView01.topAnchor, leading: layoutView01.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: layoutView01.frame.height, height: layoutView01.frame.height))

        layoutView01.addSubview(receiptTimeLabel)
        receiptTimeLabel.text = receiptTimeText
        receiptTimeLabel.anchor(top: layoutView01.topAnchor, leading: imageView01.trailingAnchor, bottom: layoutView01.bottomAnchor, trailing: layoutView01.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))



        layoutView02.addSubview(imageView02)
        imageView02.image = receiptWatchImage
        imageView02.anchor(top: layoutView02.topAnchor, leading: layoutView02.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: layoutView02.frame.height, height: layoutView02.frame.height))

        layoutView02.addSubview(receiptLabel)
        receiptLabel.text = receiptText
        receiptLabel.anchor(top: layoutView02.topAnchor, leading: imageView02.trailingAnchor, bottom: layoutView02.bottomAnchor, trailing: layoutView02.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))




        layoutView03.addSubview(imageView03)
        imageView03.image = shipmentMarkImage
        imageView03.anchor(top: layoutView03.topAnchor, leading: layoutView03.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: layoutView03.frame.height, height: layoutView03.frame.height))

        layoutView03.addSubview(shipmentLabel)
        shipmentLabel.text = shipmentText
        shipmentLabel.anchor(top: layoutView03.topAnchor, leading: imageView03.trailingAnchor, bottom: layoutView03.bottomAnchor, trailing: layoutView03.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))



        layoutView04.addSubview(imageView04)
        imageView04.image = shipmentTimeImage
        imageView04.anchor(top: layoutView04.topAnchor, leading: layoutView04.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: layoutView04.frame.height, height: layoutView04.frame.height))

        layoutView04.addSubview(shipmentTimeLabel)
        shipmentTimeLabel.text = shipmentTimeText
        shipmentTimeLabel.anchor(top: layoutView04.topAnchor, leading: imageView04.trailingAnchor, bottom: layoutView04.bottomAnchor, trailing: layoutView04.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))


    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



    //MARK: 1. Vertical Split View Parts
    let redView: CustomWidthView = {
        let view = CustomWidthView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()


    let greenView: CustomWidthView = {
        let view = CustomWidthView()
        view.translatesAutoresizingMaskIntoConstraints = false
        // view.backgroundColor = .green
        return view
    }()



    //MARK: 2. Horizontal Split Red View
    let userImage: UIImageView = {

        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.image = #imageLiteral(resourceName: "circle_manufacturer")
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        return imageView
    }()

    let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.text = "  "
        label.textAlignment = .center
        label.font = UIFont(name: "HiraKakuProN-W6", size: 12)
        return label
    }()



    //MARK: 3. Horizontal Split Red View
    let layoutView01: CustomHeightView = {
        let view = CustomHeightView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = .red
        return view
    }()

    let layoutView02: CustomHeightView = {
        let view = CustomHeightView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = .blue
        return view
    }()

    let layoutView03: CustomHeightView = {
        let view = CustomHeightView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = .yellow
        return view
    }()

    let layoutView04: CustomHeightView = {
        let view = CustomHeightView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = .green
        return view
    }()

    // --------------------------------
    //MARK: Actual View Layout
    // --------------------------------


    let imageView01: UIImageView = {

        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.image = #imageLiteral(resourceName: "icon_watch")
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        return imageView
    }()


    let receiptTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.textColor = #colorLiteral(red: 0.006700227503, green: 0.1177173927, blue: 0.6651893854, alpha: 1)
        label.text = "  Receipt Time Time Time"
        label.font = UIFont(name: "HiraKakuProN-W6", size: 12)
        return label
    }()



    let imageView02: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.image = #imageLiteral(resourceName: "icon_green")
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        return imageView
    }()

    let receiptLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "  Reciept"
        label.font = UIFont(name: "HiraKakuProN-W6", size: 12)
        return label
    }()

    let imageView03: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.image = #imageLiteral(resourceName: "icon_green")
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        return imageView
    }()

    let shipmentLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "  Shipment"
        label.font = UIFont(name: "HiraKakuProN-W6", size: 12)
        return label
    }()


    let imageView04: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.image = #imageLiteral(resourceName: "icon_watch")
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        return imageView
    }()

    let shipmentTimeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.006700227503, green: 0.1177173927, blue: 0.6651893854, alpha: 1)
        label.text = "  Shipment Time Time Time"
        label.font = UIFont(name: "HiraKakuProN-W6", size: 12)
        return label
    }()
}





class HeaderCell: UICollectionViewCell {

    //    var homeControllerObj = HomeController()

    var line01: CGFloat = 0
    var line02: CGFloat = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupViews()

    }

    let wordLabel: UILabel = {
        let label = UILabel()
        label.text = "TEST TEST TEST"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let lineVertical: UIView = {
        let line = UIView()
        line.backgroundColor = .white
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()


    let lineHorisontal: UIView = {
        let line = UIView()
        line.backgroundColor = .black
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()


    func setupViews() {
        backgroundColor = #colorLiteral(red: 0.01358020119, green: 0.1929352582, blue: 0.4004852176, alpha: 1)

        addSubview(wordLabel)
        addSubview(lineHorisontal)
        addSubview(lineVertical)


        wordLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        wordLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        wordLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        wordLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true


        lineVertical.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 200, bottom: 0, right: 0), size: CGSize(width: 1, height: 50))

        lineHorisontal.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 700, height: 2))


    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





class HistoryViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var userDataArrayInHistoryViewController:[UserData] = []


    let cellId = "cellId"
    let headerId = "headerId"


    // Button Transition to Object3dDetectionViewController
    lazy var transitionButton: UIButton = {
        let button = UIButton()

        return button
    }()



    override func viewDidLoad() {
        super.viewDidLoad()

        print("UserDataArray in HistoryViewController: ", userDataArrayInHistoryViewController)

        //        line01 = view.frame.width / 43  * 18
        //        line02 = view.frame.width / 43  * 15


        collectionView.backgroundColor = .white

        // (5) レイアウトクラスを登録する
        collectionView.register(HistoryCell.self, forCellWithReuseIdentifier: cellId)

        // headerの登録
        collectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)


        // navigationItem Left Button
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(backTapped))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white

        // navigation Title Image
//        let imageView = UIImageView(image: #imageLiteral(resourceName: "object_image_cat"))
//        imageView.contentMode = UIView.ContentMode.scaleAspectFit
//        navigationItem.titleView = imageView


        // navigation bar title
        navigationController?.navigationBar.topItem?.title = "Example Medicine History"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]



        // navigation bar color
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.07887881249, green: 0.231888473, blue: 0.5004345179, alpha: 1)


        // Button Transition to Object3dDetectionViewController
        detection3DTransitionButton.frame = CGRect(x: view.frame.maxX - 80, y: 100, width: 70, height: 70)
        view.addSubview(detection3DTransitionButton)
    }


    @objc private func backTapped() {

        // button vibration
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()

        self.dismiss(animated: true, completion: nil)
    }


    lazy var detection3DTransitionButton: UIButton = {

        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame.size = CGSize(width: 100, height: 100)
        button.setImage(UIImage(named: "detection3DButton"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.addTarget(self, action:#selector(detection3DTransitionButtonTapped), for: .touchUpInside)

        return button
    }()

    @objc func detection3DTransitionButtonTapped() { }


    // (1) セクションに何このCellを表示するかを指定する
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userDataArrayInHistoryViewController.count
    }

    // (2) セルのレイアウトを変更する
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HistoryCell


        cell.userImage.image = self.userDataArrayInHistoryViewController[indexPath.row].userImage
        cell.userNameLabel.text = userDataArrayInHistoryViewController[indexPath.row].userName

        cell.imageView01.image = #imageLiteral(resourceName: "icon_watch")
        guard let reciptTime = userDataArrayInHistoryViewController[indexPath.row].recieptTime else { return cell}
        cell.receiptTimeLabel.text = reciptTime

        cell.imageView02.image = #imageLiteral(resourceName: "icon_green")
        cell.receiptLabel.text = "Receipt"


        if  userDataArrayInHistoryViewController.canAccess(index: indexPath.row + 1) {
            // 取得できたときの処理
            cell.imageView03.image = #imageLiteral(resourceName: "icon_green")
            cell.shipmentLabel.text = "Shipment"

            cell.imageView04.image = #imageLiteral(resourceName: "icon_watch")
            guard let shipmentTime = userDataArrayInHistoryViewController[indexPath.row + 1].recieptTime else { return cell}
            cell.shipmentTimeLabel.text = shipmentTime

        } else {
            // 取得できない場合の処理
            return cell
        }

        return cell
    }


    // (3) セルのサイズを指定する（関数を表示するにはUICollectionViewDelegateFlowLayoutが必要）
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }



    // Headerのレイアウト
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        //        header.backgroundColor = .blue
        return header
    }

    // "refsizeheader"でfunctionを呼び出す。headerの大きさ
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 0)
    }



    // GradientColor
    func colorWithGradient(size: CGSize, colors: [UIColor]) -> UIColor {
        let backgroundGradientLayer = CAGradientLayer()
        backgroundGradientLayer.frame = CGRect(origin: .zero, size: size)
        backgroundGradientLayer.colors = colors.map { $0.cgColor }
        UIGraphicsBeginImageContext(size)
        backgroundGradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let backgroundColorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIColor(patternImage: backgroundColorImage!)
    }


}

