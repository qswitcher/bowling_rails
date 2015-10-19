var search_data = {"index":{"searchIndex":["applicationcontroller","applicationhelper","frame","framescontroller","frameshelper","game","gamescontroller","gameshelper","create()","create()","cumulative_score()","destroy()","destroy()","frames_by_player_id()","index()","index()","last_frame?()","next_frame()","next_roll()","next_two_rolls()","number()","previous_frame()","score()","score_for_player()","show()","show()","spare?()","strike?()","update()","update()","readme"],"longSearchIndex":["applicationcontroller","applicationhelper","frame","framescontroller","frameshelper","game","gamescontroller","gameshelper","framescontroller#create()","gamescontroller#create()","frame#cumulative_score()","framescontroller#destroy()","gamescontroller#destroy()","game#frames_by_player_id()","framescontroller#index()","gamescontroller#index()","frame#last_frame?()","frame#next_frame()","frame#next_roll()","frame#next_two_rolls()","frame#number()","frame#previous_frame()","frame#score()","game#score_for_player()","framescontroller#show()","gamescontroller#show()","frame#spare?()","frame#strike?()","framescontroller#update()","gamescontroller#update()",""],"info":[["ApplicationController","","ApplicationController.html","",""],["ApplicationHelper","","ApplicationHelper.html","",""],["Frame","","Frame.html","","<p>Represents a single frame for a single player in a bowling game. Each\nplayer can have up to 10 frames …\n"],["FramesController","","FramesController.html","",""],["FramesHelper","","FramesHelper.html","",""],["Game","","Game.html","","<p>Represents a single bowling game.\n"],["GamesController","","GamesController.html","",""],["GamesHelper","","GamesHelper.html","",""],["create","FramesController","FramesController.html#method-i-create","()","<p>POST /frames\n"],["create","GamesController","GamesController.html#method-i-create","()","<p>POST /games\n"],["cumulative_score","Frame","Frame.html#method-i-cumulative_score","()","<p>Returns the total score of the game for the player up to and including this\nframe.\n"],["destroy","FramesController","FramesController.html#method-i-destroy","()","<p>DELETE /frames/1\n"],["destroy","GamesController","GamesController.html#method-i-destroy","()","<p>DELETE /games/1\n"],["frames_by_player_id","Game","Game.html#method-i-frames_by_player_id","()","<p>Returns the frames for this game, grouped by player_id\n"],["index","FramesController","FramesController.html#method-i-index","()","<p>GET /frames\n"],["index","GamesController","GamesController.html#method-i-index","()","<p>GET /games\n"],["last_frame?","Frame","Frame.html#method-i-last_frame-3F","()","<p>Returns true if this is the last frame of the game for a player\n"],["next_frame","Frame","Frame.html#method-i-next_frame","()","<p>Returns the frame which follows this frame, if it exists\n"],["next_roll","Frame","Frame.html#method-i-next_roll","()","<p>Returns the next roll in the next frame\n"],["next_two_rolls","Frame","Frame.html#method-i-next_two_rolls","()","<p>Returns the next two rolls in the next frames\n"],["number","Frame","Frame.html#method-i-number","","<p>Enforces joint uniqueness of (number, player_id, game_id) to prevent\nduplicate frames per game per player …\n"],["previous_frame","Frame","Frame.html#method-i-previous_frame","()","<p>Returns the frame which proceeds this frame, if it exists\n"],["score","Frame","Frame.html#method-i-score","()","<p>Returns the points earned for this frame using the rules of bowling, which\nfollow the rules\n<p>Strikes A …\n"],["score_for_player","Game","Game.html#method-i-score_for_player","(player_id)","<p>Returns the total score for a player for this game if it exists, nil\notherwise.\n"],["show","FramesController","FramesController.html#method-i-show","()","<p>GET /frames/1\n"],["show","GamesController","GamesController.html#method-i-show","()","<p>GET /games/1\n"],["spare?","Frame","Frame.html#method-i-spare-3F","()","<p>Returns true if this frame is a spare, which occurs if the player knocked\ndown all 10 pins in 2 tries …\n"],["strike?","Frame","Frame.html#method-i-strike-3F","()","<p>Returns true if this frame is a strike which occurs if all 10 pins are\nknocked down in the first shot …\n"],["update","FramesController","FramesController.html#method-i-update","()","<p>PUT /frames/1\n"],["update","GamesController","GamesController.html#method-i-update","()","<p>PATCH/PUT /games/1\n"],["README","","README_rdoc.html","","<p>README\n<p>This README would normally document whatever steps are necessary to get the\napplication up and …\n"]]}}