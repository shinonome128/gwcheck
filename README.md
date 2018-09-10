# gwcheck  
  
## 目的  
  
BYOD環境、社外でVDI接続しているとよく止まる  
NWが重いのか、VDIが悪いのかわからない  
ネットワークが悪いかどうかをすぐに分かるようにしたい  
だいたいPing 打ってるんで自動化  
  
## 参照  
  
Wox + Everything  
https://syon.github.io/refills/rid/1501413/  
  
## 各ファイル内容  
  
.gitignore  
非管理対象ファイル  
VIMのスワップファイルとか  
  
README.md  
取説  
  
gw.bat  
WoXから起動  
社外なら Google DNS(8.8.8.8)にPing  
社内だとICMP落とすので、GWまでPing  
環境を自動判断しPingしてネットワーク環境に依存するかどうかを自動実行  
  
以上  
