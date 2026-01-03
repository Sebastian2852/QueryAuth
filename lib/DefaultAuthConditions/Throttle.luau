--[=[
	Checks to see if time (*t*) is greater or equal to time passed since the last time the condition returned true.
	This take into account intervals for individual players, tracking each interval for each player that was passed into the condition.
	For a global functionality that does not separate player's intervals, use `QueryAuth.GlobalThrottle`
	@function Throttle
	@within QueryAuth
	@param time number -- The time to check against, time unit depends on which function was passed on *mark*, but by default it's in seconds.
	@param mark function -- An optional function which will be used to track intervals inside the function, defaults to `os.clock`
	@return AuthCondition -- A lambda that returns true if passed time parameter is greater or equal to time passed since last truthy return.
]=]
return function(time: number, mark: (()->number)?)
    local fn = if mark then mark else os.clock
    local tracker: {[Player]: number} = {}

    return function(player: Player)
        local now = fn()
        local last = tracker[player] 

        if last == nil or now-last >= time then
            tracker[player] = now

            return true
        end

        return false
    end
end
