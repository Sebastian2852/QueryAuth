--[=[
	A player time-based rate limiter, only returning true if you call it less than `times` amount of times within the `timeFrame` amount of time for a given player.
	@function Throttle
	@within QueryAuth
	@param timeFrame number -- The amount of time (seconds by default) between resetting the amount of calls that can happen.
	@param times number? -- The maximum amount of calls allowed within the given `timeFrame` (defaults to 1).
	@param mark (()->number)? -- An optional function which will be used to track intervals inside the function, defaults to `os.clock`
	@return AuthCondition -- A lambda that returns true if passed time parameter is greater or equal to time passed since last truthy return.
]=]
return function(timeFrame: number, times: number?, mark: (() -> number)?)
	local getTimeFn: () -> number = if mark then mark else os.clock
	times = times or 1

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
