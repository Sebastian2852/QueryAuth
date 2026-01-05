--[=[
	A global time-based rate limiter, only returning true if you call it less than `times` amount of times within the `timeFrame` amount of time.
	@function GlobalThrottle
	@within QueryAuth
	@param timeFrame number -- The amount of time (seconds by default) between resetting the amount of calls that can happen.
	@param times number? -- The maximum amount of calls allowed within the given `timeFrame` (defaults to 1).
	@param mark (()->number)? -- An optional function which will be used to track intervals inside the function. (defaults to `os.clock`)
	@return AuthCondition -- A lambda that returns true if passed time parameter is greater or equal to time passed since last truthy return.
]=]
return function(timeFrame: number, times: number?, mark: (() -> number)?)
	local getTimeFn: () -> number = if mark then mark else os.clock
	times = times or 1

	local callsLeft = times
	local lastRefill = getTimeFn()

	return function(player: Player)
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
		return true
	end
end
