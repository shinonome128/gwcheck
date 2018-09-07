@ECHO OFF


REM ///////////////////////////////////////////////////
REM 処理の流れ
REM 1.ipconfigをたたく
REM 2.GWを変数に格納する
REM 3.マッチングして分岐する
REM     NOS社内
REM     GWにXXXが含まれる
REM 4.        デフォゲに打つ
REM     NOS社内以外
REM     それ以外
REM 5.        8.8.8.8に打つ
REM ///////////////////////////////////////////////////


REM ///////////////////////////////////////////////////
REM 処理の流れ
REM 1.ipconfigをたたく
REM 2.GWを変数に格納する
REM
REM GW変数の中身を初期化する
REM これをしないと前回の中身がのこってしまいIPv6環境で誤作動を起こす

set GW=0

REM ゲートウェイアドレスを変数GWに格納
REM GWアドレスはipconfigの結果で空白行から始まる
REM ipconfigの楊淳出力をfindstrで検索し
REM /rは正規表現
REM /c:"   "はスペースも検索対象にする
REM for /f で文字列を取り出す
REM デフォルトのデリミタはスペースなので最初の文字列をtokens=1で取り出している

for /F "tokens=10" %%i in ('ipconfig ^|findstr "デフォルト ゲートウェイ" ^|findstr /V "::"') do @set GW=%%i

REM 変数GWの確認用コマンド
REM set GW
REM ///////////////////////////////////////////////////


REM ///////////////////////////////////////////////////
REM 処理の流れ
REM 3.マッチングして分岐する
REM     社内だと10.13x.x.x
REM     社外だとそれ以外
REM 4.        デフォゲに打つ
REM     NOS社内以外
REM     それ以外
REM 5.        8.8.8.8に打つ
REM
REM set GWの標準をfindstrの文字列検索する
REM 検索結果は不要なのでNULLに送る
REM エラーコードが1でなければGWにpingを実行
REM ERRORLEVELはコマンドにより返り値がことなる
REM findstrだと1は検索条件にアンマッチ

set GW|findstr /C:"10.13">NUL
if not ERRORLEVEL 1 ( 
    start ping -t %GW%
) else ( 
    start ping -t 8.8.8.8
)

REM ///////////////////////////////////////////////////
