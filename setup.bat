@echo off 

@REM 远程服务器ip
set remote_ip=11.22.33.44
@REM 存档文件
set save_file="test1.zip"
@REM Factorio账户名
set username=FACUSER
@REM Factorio账户密码
set password=PASSWORD123
@REM 游戏房间密码
set game_password=114514
@REM 是否能被游戏大厅搜索到
set visibility_public=false
@REM 管理员角色名称列表
set admins="PLAYER1","PLAYER2","PLAYER3"

@REM 下面几项不用改
@REM 服务器配置文件
set setting_file="server-settings.json"
@REM 管理员列表文件
set admin_list_file="server-adminlist.json"
@REM 启动脚本文件
set start_script="start.sh"


@echo off
REM Step 1: Create the setting file

echo { > %setting_file%
echo   "name": "Name of the game as it will appear in the game listing", >> %setting_file%
echo   "description": "Description of the game that will appear in the listing", >> %setting_file%
echo   "tags": [ "game", "tags" ], >> %setting_file%
echo   "_comment_max_players": "Maximum number of players allowed, admins can join even a full server. 0 means unlimited.", >> %setting_file%
echo   "max_players": 0, >> %setting_file%
echo   "_comment_visibility": [ >> %setting_file%
echo     "public: Game will be published on the official Factorio matching server", >> %setting_file%
echo     "lan: Game will be broadcast on LAN" >> %setting_file%
echo   ], >> %setting_file%
echo   "visibility": { >> %setting_file%
echo     "public": %visibility_public%, >> %setting_file%
echo     "lan": true >> %setting_file%
echo   }, >> %setting_file%
echo   "_comment_credentials": "Your factorio.com login credentials. Required for games with visibility public", >> %setting_file%
echo   "username": "%username%", >> %setting_file%
echo   "password": "%password%", >> %setting_file%
echo   "_comment_token": "Authentication token. May be used instead of 'password' above.", >> %setting_file%
echo   "token": "", >> %setting_file%
echo   "game_password": "%game_password%", >> %setting_file%
echo   "_comment_require_user_verification": "When set to true, the server will only allow clients that have a valid Factorio.com account", >> %setting_file%
echo   "require_user_verification": true, >> %setting_file%
echo   "_comment_max_upload_in_kilobytes_per_second": "optional, default value is 0. 0 means unlimited.", >> %setting_file%
echo   "max_upload_in_kilobytes_per_second": 0, >> %setting_file%
echo   "_comment_max_upload_slots": "optional, default value is 5. 0 means unlimited.", >> %setting_file%
echo   "max_upload_slots": 5, >> %setting_file%
echo   "_comment_minimum_latency_in_ticks": "optional one tick is 16ms in default speed, default value is 0. 0 means no minimum.", >> %setting_file%
echo   "minimum_latency_in_ticks": 0, >> %setting_file%
echo   "_comment_max_heartbeats_per_second": "Network tick rate. Maximum rate game updates packets are sent at before bundling them together. Minimum value is 6, maximum value is 240.", >> %setting_file%
echo   "max_heartbeats_per_second": 60, >> %setting_file%
echo   "_comment_ignore_player_limit_for_returning_players": "Players that played on this map already can join even when the max player limit was reached.", >> %setting_file%
echo   "ignore_player_limit_for_returning_players": false, >> %setting_file%
echo   "_comment_allow_commands": "possible values are, true, false and admins-only", >> %setting_file%
echo   "allow_commands": "admins-only", >> %setting_file%
echo   "_comment_autosave_interval": "Autosave interval in minutes", >> %setting_file%
echo   "autosave_interval": 10, >> %setting_file%
echo   "_comment_autosave_slots": "server autosave slots, it is cycled through when the server autosaves.", >> %setting_file%
echo   "autosave_slots": 5, >> %setting_file%
echo   "_comment_afk_autokick_interval": "How many minutes until someone is kicked when doing nothing, 0 for never.", >> %setting_file%
echo   "afk_autokick_interval": 0, >> %setting_file%
echo   "_comment_auto_pause": "Whether should the server be paused when no players are present.", >> %setting_file%
echo   "auto_pause": true, >> %setting_file%
echo   "_comment_auto_pause_when_players_connect": "Whether should the server be paused when someone is connecting to the server.", >> %setting_file%
echo   "auto_pause_when_players_connect": false, >> %setting_file%
echo   "only_admins_can_pause_the_game": true, >> %setting_file%
echo   "_comment_autosave_only_on_server": "Whether autosaves should be saved only on server or also on all connected clients. Default is true.", >> %setting_file%
echo   "autosave_only_on_server": true, >> %setting_file%
echo   "_comment_non_blocking_saving": "Highly experimental feature, enable only at your own risk of losing your saves. On UNIX systems, server will fork itself to create an autosave. Autosaving on connected Windows clients will be disabled regardless of autosave_only_on_server option.", >> %setting_file%
echo   "non_blocking_saving": false, >> %setting_file%
echo   "_comment_segment_sizes": "Long network messages are split into segments that are sent over multiple ticks. Their size depends on the number of peers currently connected. Increasing the segment size will increase upload bandwidth requirement for the server and download bandwidth requirement for clients. This setting only affects server outbound messages. Changing these settings can have a negative impact on connection stability for some clients.", >> %setting_file%
echo   "minimum_segment_size": 25, >> %setting_file%
echo   "minimum_segment_size_peer_count": 20, >> %setting_file%
echo   "maximum_segment_size": 100, >> %setting_file%
echo   "maximum_segment_size_peer_count": 10 >> %setting_file%
echo } >> %setting_file%


@REM Step 2: Create the admin list file
echo [ > %admin_list_file%
echo %admins% >> %admin_list_file%
echo ] >> %admin_list_file%


@REM Step 3: Create the start_script
echo ./factorio/bin/x64/factorio --port 34197 --server-settings %setting_file% --server-adminlist %admin_list_file% --start-server %save_file% > %start_script%


@REM Step 4: package the files
tar -czvf _fac_pack.tar.gz %save_file% %setting_file% %admin_list_file% %start_script%


@REM Step 5: Upload the files to the server
scp _fac_pack.tar.gz root@%remote_ip%:/root/


@REM Step 6: Connect to the server and execute commands
ssh root@%remote_ip% "tar -xavf _fac_pack.tar.gz; wget -O factorio.tar.xz https://factorio.com/get-download/stable/headless/linux64; tar xvf factorio.tar.xz;  chmod 777 ./start.sh; screen -S fac -dm bash -c './%start_script%'"

echo 异星，启动！

pause