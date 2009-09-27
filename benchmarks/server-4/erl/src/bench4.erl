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
handle(["timestamp"], Req) ->
	Stamp = current_timestamp(),
	Req:ok([], "~B", [Stamp]);

handle(["login"], Req) ->
	Vars = Req:parse_qs(),
	{value, {_, Username}} = lists:keysearch("username", 1, Vars),
	NewSessID = new_uuid(),
	SessionDict = dict:from_list([{username, Username}, {name, "Test Dude"}]),
	ets:insert_new(sessions, {NewSessID, SessionDict}),
	Req:ok([{"Set-Cookie", "sid=" ++ NewSessID}], "~s is awesome", [new_uuid()]);

handle(["name"], Req) ->
	Headers = Req:get(headers),
	{value, {_, Cookies}} = lists:keysearch('Cookie', 1, Headers),
	Req:ok([], "~p", [Cookies]);
	%[_,_,_,_|SID] = Cookies,
	%Req:ok([], "~p", [SID]);
	%Req:ok([], "~p", [Headers]);
	%[SessionDict] = ets:lookup(sessions, 

handle(_, Req) ->
	Req:ok("page not found").


%---------------------------- 



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

