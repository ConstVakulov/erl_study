-module(kitchen).
-export([fridge1/0]).
-export([fridge2/1]).

fridge1() ->
	receive
		{From,{store,Food}} ->
			From ! {self(),{polozhil, Food}},
			fridge1();
		{From,{take,_Food}} ->
			From ! {self(),brat_nechego},
			fridge1();
		_ -> kakaya_to_huinya
	end.
	
fridge2(FoodList) ->
	receive
		{From,{store, Food}} ->
			From ! {self(),{polozhil, Food}},
			fridge2([Food|FoodList]);
		{From, {take, Food}} ->
			case lists:member(Food, FoodList) of
				true ->
					From ! {self(),{vzyal,Food}},
					fridge2(lists:delete(Food,FoodList));
				false ->
					From ! {self(),not_found},
					fridge2(FoodList)
			end;
		{From, _} -> From ! {self(),FoodList}
	end.
			