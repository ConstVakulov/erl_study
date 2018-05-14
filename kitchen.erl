-module(kitchen).
-export([fridge/0,fridge2/1]).

fridge() ->
	receive
		{From,{store,Food}} ->
			From ! {polozhil, Food},
			fridge();
		{From,{take,_Food}} ->
			From ! brat_nechego,
			fridge();
		_ -> kakaya_to_huinya
	end.
	
fridge2(FoodList) ->
	receive
		{From,{store, Food}} ->
			From ! {polozhil, Food},
			fridge2([Food|FoodList]);
		{From, {take, Food}} ->
			case lists:member(Food, FoodList) of
			