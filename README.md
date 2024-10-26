异星工厂DLC已于近日发布。
本项目为异星工厂云服务器一键开服的脚本，可将一份本地存档上传至云服务器并基于该存档开启游戏，方便各位厂长做大做强。（目前仅支持Windows）

## 最近更新

- 2024-10-26 添加了远程服务器更新游戏版本的功能
- 2024-10-23 在bat文件中内置说明

## 使用方法

1. 下载脚本文件[setup.bat](./setup.bat)
2. 将本地异星工厂存档(.zip)文件放入脚本文件所在目录
3. 右键脚本文件，或使用VSCode等工具编辑脚本文件，修改填写第11行~第17行，包括以下内容
   1. 远程服务器ip
   2. 存档文件名
   3. Factorio账户名
   4. Factorio账户密码
   5. 游戏房间密码
   6. 是否能被游戏大厅搜索到（true或false）
   7. 管理员角色名称列表，角色名称使用双引号包裹，多个角色名称之间使用逗号分隔
4. 双击运行脚本文件
5. 在命令行弹出某个询问"[yes/no]"时，输入yes（这是首次远程连接该服务器才会出现的询问，后续连接不会再出现）
6. 在命令行中弹出输入密码的询问时，输入云服务器的登陆密码（一共出现两次，一次为上传文件，一次为登陆远程服务器运行脚本）
7. 命令行最后一行出现“按任意键继续……”或“按Enter键继续……”字样时，完成服务端搭建。在游戏中“多人游戏”-“服务器直连”中输入服务器ip即可游玩。

## 脚本说明
[脚本文件](./setup.bat)主要操作包括
1. 创建服务端配置文件
2. 创建管理员列表文件
3. 创建服务端脚本
4. 将上述文件及存档文件打包scp发送至远程服务器并解压
5. 在远程服务器上运行服务端脚本

## 支持与限制

- 目前跑通阿里云服务器ECS，并需要
  - 使用密码登陆
  - 在安全组中开放34197端口
- 目前仅支持Windows，Linux和MacOS需要自行修改脚本
- 目前脚本中没有上传mods的功能（新版本应该也没多少兼容的mod吧）