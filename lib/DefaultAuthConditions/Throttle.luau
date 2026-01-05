--[=[
	Checks to see if time (*t*) is greater or equal to time passed since the last time the condition returned true.
	This take into account intervals for individual players, tracking each interval for each player that was passed into the condition.
	For a global functionality that does not separate player's intervals, use `QueryAuth.GlobalThrottle`
	@function Throttle
	@within QueryAuth
	@param time number -- The time to check against, time unit depends on which function was passed on *mark*, but by default it's in seconds.
	@param mark (()->number)? -- An optional function which will be used to track intervals inside the function, defaults to `os.clock`
	@return AuthCondition -- A lambda that returns true if passed time parameter is greater or equal to time passed since last truthy return.
]=]
return function(times: number, timeFrame: number, mark: (() -> number)?)
	local getTimeFn: () -> number = if mark then mark else os.clock

	local playerInfos = {} :: { [Player]: { callsLeft: number, lastRefill: number } }

	return function(player: Player)
		local playerInfo = playerInfos[player] or { callsLeft = times, lastRefill = getTimeFn() }
		local callsLeft = playerInfo.callsLeft
		local lastRefill = playerInfo.lastRefill

		local now = getTimeFn()
		local elapsed = now - lastRefill

		if elapsed >= timeFrame then
			callsLeft = times
			lastRefill = now
		end

		if callsLeft == 0 then
			return false
		end

		callsLeft -= 1
		playerInfos[player] = { callsLeft = callsLeft, lastRefill = lastRefill }
		return true
	end
end
