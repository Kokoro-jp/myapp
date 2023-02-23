# OFFlyer  
 
OFFlyerとは、お店が売り切りたい **割引商品（OFF）** を、少しでも安く商品を買いたいecoユーザーに、写真を投稿するだけで **「電子チラシ（Flyer）」** として、届けられるサービスです。

## Demo  
![OFFlyer_intro](https://user-images.githubusercontent.com/84630152/220847565-8d131553-d80f-4908-a6cb-0de9349b7c46.gif)



## 使用技術 
* Ruby version 3.1.3  
* Ruby on Rails version 6.1.7   
* MySQL version 5.7.40
* Nginx
* Unicorn
* AWS (EC2, VPC, RDS, EIP, IAM)
* Docker version 20.10.21  
* Docker-compose version v2.13.0  
* Github Actions CI
* RSpec
* Google Maps API

## 機能一覧  
* ユーザー/店舗 登録・ログイン機能 (devise)  
* ゲストログイン機能 (devise)  
* 画像投稿機能 (CarrierWave)  
* Preview機能
* お気に入り機能 (Ajax)  
* 閲覧数表示機能(Impressionist)  
* 検索機能 (ransack)  
* 店舗位置情報表示 (Google Maps API)  

## テスト
* RSpec  
  * 単体テスト(model)
  * 機能テスト (request)

## こだわった点  
サービス全体のこだわりとしては、誰でも使いやすく親しみやすいデザインを心がけて作成しました。  
個人ユーザー側では、preview機能を用いて投稿された画像を見やすくすること、購入チャンスを逃さないため、投稿・更新された日時、Google Maps APIを使った店舗情報を表示することを取り入れました。  
店舗ユーザー側では、投稿に対してのユーザーの反応などを確認できるよう、お気に入り数や閲覧数をチェックできるようにしました。   
また、


## 今後取り組んでいくもの
* 独自ドメイン取得   
* HTTPS化  
* Capistranoを使った自動デプロイ  
* Github Actions CD  
* ページネーション機能 (kaminari)  
  * 無限スクロール (Ajax)


## Author
Kokoro Matsuno

## Lisence   
The source code is licensed MIT.
