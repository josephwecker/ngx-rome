-module(bench4).

-export([start/1, stop/0, handle_http/1, new_uuid/0]).

start(Port) ->
	ets:new(sessions, [set, public, named_table]),
	crypto:start(),
	misultin:start_link([{port, Port}, {loop, fun(Req) -> handle_http(Req) end}]).

stop() ->
	misultin:stop().

handle_http(Req) ->
	handle(Req:resource([lowercase, urldecode]), Req).


%---------------------------- 
handle([".misultin","timestamp"], Req) ->
	Stamp = current_timestamp(),
	Req:ok([], "~B", [Stamp]);

handle([".misultin","begin"], Req) ->
	Vars = Req:parse_post(),
	{value, {_, Username}} = lists:keysearch("username", 1, Vars),
	NewSessID = new_uuid(),
	SessionDict = dict:from_list([{username, Username}, {name, "Test Dude"}]),
	ets:insert_new(sessions, {NewSessID, SessionDict}),
	Req:respond(303,
		[{"Set-Cookie", "sid=" ++ NewSessID ++ "; path=/;"},
		{"Location", "/welcome1.html"}], "");

handle([".misultin","name"], Req) ->
	SessionDict = get_session(Req),
	{ok, Name} = dict:find(name, SessionDict),
	Req:ok([], "~s", [Name]);

handle([".misultin","name_username"], Req) ->
	SessionDict = get_session(Req),
	{ok, Username} = dict:find(username, SessionDict),
	{ok, Name} = dict:find(name, SessionDict),
	Req:ok([], "~s (~s)", [Name, Username]);

handle([".misultin","username"], Req) ->
	SessionDict = get_session(Req),
	{ok, Username} = dict:find(username, SessionDict),
	Req:ok([], "~s", [Username]);

handle([".misultin","5divs"], Req) ->
	D = ["first", "second", "third", "forth", "fifth"],
	{Out,_} = lists:mapfoldl(
		fun(Term,I) ->
			{"<div class=\"strange\">" ++ integer_to_list(I) ++ "---&gt;" ++ Term ++ "</div>", I+1}
		end, 1, D),
	Req:ok([], lists:flatten(Out), []);
			

handle(_, Req) ->
	Req:ok("[NOT IMPLEMENTED YET]").


%---------------------------- 
get_session(Req) ->
	Headers = Req:get(headers),
	{value, {_, Cookies}} = lists:keysearch('Cookie', 1, Headers),
	Start = string:str(Cookies, "sid="),
	SID = string:substr(Cookies, Start + 4, 32),
	%Cookies = get_cookies(Headers),
	%{value, {_, SID}} = lists:keysearch("sid", 1, Cookies),
	[{_, SessionDict}] = ets:lookup(sessions, SID),
	SessionDict.


%get_cookies(Headers) ->
%	case lists:keysearch('Cookie', 1, Headers) of
%	{value, {_, Cookies}} ->
%		mochiweb_cookies:parse_cookie(Cookies);
%	_ -> []
%	end.



%---------------------------- 
current_timestamp() ->
	UniversalNow = calendar:now_to_universal_time(erlang:now()),
	calendar:datetime_to_gregorian_seconds(UniversalNow) - 62167219200.

%---------------------------- 
new_uuid() ->
    to_hex(crypto:rand_bytes(16)).
    
to_hex([]) ->
    [];
to_hex(Bin) when is_binary(Bin) ->
    to_hex(binary_to_list(Bin));
to_hex([H|T]) ->
    [to_digit(H div 16), to_digit(H rem 16) | to_hex(T)].

to_digit(N) when N < 10 -> $0 + N;
to_digit(N)             -> $a + N-10.

